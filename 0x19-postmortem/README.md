Postmortem: Production Outage due to Unvetted Configuration Change

Issue Summary:

This report details a production outage that occurred on Wednesday, June 5th, 2024, between 14:12 PST and 15:07 PST (UTC-7). The outage resulted in blocked ports, preventing incoming requests and rendering internal APIs unreachable. It is estimated that 80% of users experienced issues during this timeframe.


Root Cause:

An unapproved configuration change was deployed directly to the production environment, bypassing the standard testing process. This change inadvertently blocked critical ports used by internal services.


Timeline:

	14:12 PST: Monitoring alerts indicated a surge in connection errors on several internal services.
	14:13 PST: An engineer on-call identified a significant drop in incoming traffic and initiated investigation.
	14:15 PST: Initial investigation focused on potential application issues, but system logs revealed no errors within the application tier.
	14:20 PST: The investigation pivoted towards network infrastructure, analyzing firewall logs and configurations.
	14:30 PST: A network engineer discovered a recent configuration change that coincided with the reported issues. This change was identified as untested and potentially related to the outage.
	14:35 PST: The incident was escalated to the infrastructure management team and the product owner.
	14:40 PST: The infrastructure team confirmed the configuration change as the root cause and initiated a rollback procedure.
	14:50 PST: The configuration change was reverted, and network connectivity began to restore.
	15:00 PST: Internal services became fully reachable, and monitoring confirmed stable operation.
	15:07 PST: The incident was declared resolved, and a postmortem meeting was scheduled.

Root Cause and Resolution:

The unvetted configuration change introduced a firewall rule that inadvertently blocked essential ports used by internal services for communication. Reverting this change restored network connectivity and allowed internal APIs to function normally.

Corrective and Preventative Measures:

	Mandatory code review and testing: All configuration changes, including those related to network infrastructure, must undergo a rigorous review and testing process before deployment to production.
	Enhanced monitoring: Implement stricter monitoring for firewall changes, including real-time alerts for critical port modifications.
	Change management enforcement: Strengthen change management protocols to ensure proper approvals and notifications before deploying changes to production environments.
	Automated testing framework: Develop an automated testing framework to simulate the impact of configuration changes on the production environment before manual deployment.
	Improved communication: Foster better communication between development, infrastructure, and operations teams to ensure awareness of planned changes and potential impact.
