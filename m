Subject: Re: making progress...a few comments..
From: Karl MacMillan <kmacmillan@tresys.com>
To: Mark Shakespeare <mshakes@llnl.gov>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <p06020408bc3db651f5a5@[128.115.96.64]>
References: <p06020408bc3db651f5a5@[128.115.96.64]>
Content-Type: text/plain
Message-Id: <1075389930.13803.69.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Thu, 29 Jan 2004 10:25:30 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-01-28 at 14:20, Mark Shakespeare wrote:

> I downloaded setools from www.tresys.com, in order to install BWidgets.
> 
> Some setools components required TK and TCL 8.3, while setools-gui
> requires TK and TCL 8.4
> 

It sounds like you are using a mix of our rpms and Dan Walsh's. You said
that you downloaded setools from our website, but the packages there
don't have setools-gui. So you need to double check which set of rpms
you are using and only use Tresys packages or Dan Walsh's. You will
probably be better off for the long term if you use Dan's.

To avoid this confusion in the future we are going to stop distributing
rpms entirely starting with the next release.

Karl

> I forced tk and tcl8.4 using the rpm -i --force....so both are installed.
> 
> The script now completes.....and we now have a bootable selinux system...
> 
> well sort of...
> vi does not work....has a libperl.so error
> id -Z does not work....says it can only be used on a selinux-enabled kernel
> seaudit fails...something about a bad policy.conf file...
> 
> 
> The also appears to be no logging for selinux related events.
> 
> 
> Any suggestions are welcome.
> 
> 
> Thanks.
> 
> 								Mark
-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
http://www.tresys.com
(410) 290-1411 x134


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
