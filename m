Message-ID: <527A5646.1090801@tycho.nsa.gov>
Date: Wed, 06 Nov 2013 09:46:30 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Richard Haines <richard_c_haines@btinternet.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH 2/2] checkpolicy: Add debug feature to display constraints
 / validatetrans
References: <1383505949-2639-1-git-send-email-richard_c_haines@btinternet.com>
In-Reply-To: <1383505949-2639-1-git-send-email-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/03/2013 02:12 PM, Richard Haines wrote:
> Allow mls/constraint mls/validatetrans constraints to be displayed
> in debug mode. If POLICY_KERN version is >=
> POLICYDB_VERSION_CONSTRAINT_NAMES then the policy defined
> types/attributes will be returned.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

All three patches merged to #next.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
