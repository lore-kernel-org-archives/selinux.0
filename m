Subject: Re: question about remote login
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: lky <lky77@sjtu.edu.cn>
Cc: SELINUX <SELinux@tycho.nsa.gov>
In-Reply-To: <001e01c3c65f$5849f320$5d38a8c0@lky>
References: <001e01c3c65f$5849f320$5d38a8c0@lky>
Content-Type: text/plain
Message-Id: <1071865851.11143.98.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 19 Dec 2003 15:30:51 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-12-19 at 13:38, lky wrote:
> Hi:
>     I have installed selinux-2.4.21 on RedHat9.0. 

I'd suggest updating to the current release.  2.4.23 or 2.6.0-test11.  I
also have a patch against 2.6.0 if you'd like to use that.

> Now I want to login my machine remotely.But I found I can't login with
> telnet if SElinux is enabled.SElinux don't support telnet? I didn't
> find the .te file for telnet.Then I have to use ssh now.

ssh is preferred anyway, but there is example policy support for telnet
if you include the inetd.te and rlogind.te files in your policy.  They
are not included by default; you have to move them up from
policy/domains/program/unused if you want them.

> But there is still a problem. I have enabled MLS in SElinux. One of my
> users is labeled as secret level(unclassified as default). Now I can't
> ssh as the secret user.The denied messages appear that the secret user
> can't access the ssh_t objects cause ssh_t is labeled as unclassified.
> How can I ssh to my machine as both secret and unclassified users? 

As noted in the documentation and previously on the list, the MLS policy
is experimental and has not configured for use.  Areas where it could be
improved include re-integrating the MLS logic with the TE logic so that
a separate TE access vector can be specified per MLS relation, making
sure that the MLS configuration is correct, implementing
polyinstantiation support, and userland integration.  Not a priority to
us at the moment, feel free to contribute.

>     By the way I want to know how to disable the display of deny
> messages on screen? Is there a command?

They are handled by the normal kernel logging infrastructure.  You can
set the log level via the avc_log_level= kernel boot parameter.  The
default level is 4 (KERN_WARNING).  You can alter the behavior of klogd
or syslogd in the usual manner, see their man pages.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
