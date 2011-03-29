Message-ID: <4D91F135.2050809@tresys.com>
Date: Tue, 29 Mar 2011 10:48:21 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: selinux@tycho.nsa.gov, method@manicmethod.com, sds@tycho.nsa.gov
Subject: Re: [PATCH] checkpolicy: add support for using last path component
 in type transition rules
References: <1301335220.14296.27.camel@localhost.localdomain>
In-Reply-To: <1301335220.14296.27.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/28/11 14:00, Eric Paris wrote:
> This patch adds support for using the last path component as part of the
> information in making labeling decisions for new objects.  A example
> rule looks like so:
> 
> type_transition unconfined_t etc_t:file system_conf_t eric;
> 
> This rule says if unconfined_t creates a file in a directory labeled
> etc_t and the last path component is "eric" (no globbing, no matching
> magic, just exact strcmp) it should be labeled system_conf_t.
> 
> The kernel and policy representation does not have support for such
> rules in conditionals, and thus policy explicitly notes that fact if
> such a rule is added to a conditional.

Is there any plan for getting conditional support?


-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
