Date: Sat, 1 Jan 2005 15:20:24 -0700 (MST)
From: Matthew Leinhos <leinhos@lamar.colostate.edu>
To: Jaspreet Singh <jsingh@ensim.com>
cc: nsa <SELinux@tycho.nsa.gov>
Subject: Re: Newrole in targeted mode
In-Reply-To: <1104388628.3140.4.camel@jsingh>
Message-ID: <Pine.A41.4.58.0501011514130.421018@lamar.ColoState.EDU>
References: <1104259373.22401.0.camel@hawaii.grays-systems.com>
 <1104259847.21391.107.camel@moss-spartans.epoch.ncsc.mil> <1104388628.3140.4.camel@jsingh>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Jaspreet,

I'm fairly new to SELinux, but I'll try to answer your question.

The goal in running SELinux under a targeted policy is to shield specific
processes, generally daemons available to the network, under the
protections of SELinux. In other words, its goal is to make it so that a
remote break-in via a daemon vulnerability is not catestrophic to the
system's security.

The goal of the strict policy is to protect the system against not only
vulnerabilities in daemons, but also against malicious (but possible
legitamate) users. So, the strict policy is more elaborate and will
provide more protections to the system, once its bugs have been wrinkled
out.

These policies are in development on Fedora Core 3. Refer to

http://fedora.redhat.com/docs/selinux-faq-fc3/index.html#id2801831

for more information.

-Matt


On Thu, 30 Dec 2004, Jaspreet Singh wrote:

> Hi,
>
> I tried to search and couldn't find any threads on this question ..
>
> What are the basic differences between targeted and strict policies ..
>
> All I know is .. there are lesser targeted domains/roles in target
> policy compared to strict and as a result most domains run in an
> unconfined_t domain.
>
> Am I missing something ...
>
> On Tue, 2004-12-28 at 13:50 -0500, Stephen Smalley wrote:
> > newrole serves no purpose under targeted policy; users are unconfined.
> > setenforce 0 should work for you as root (from unconfined_t, of course,
> > which is what you should already be in for a user session).
>
> You can add new users and roles in target policy also ...
> In that case newrole should work as per the modified policies .. I am wrong ??
>
> Regards,
> Jaspreet
>
> --
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
