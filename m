Subject: Re: Question about newrole
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dennis Wronka <linuxweb@gmx.net>
Cc: SELinux Mailing List <selinux@tycho.nsa.gov>
In-Reply-To: <200808052155.18105.linuxweb@gmx.net>
References: <200808052155.18105.linuxweb@gmx.net>
Content-Type: text/plain
Date: Tue, 05 Aug 2008 10:13:34 -0400
Message-Id: <1217945614.2994.74.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-08-05 at 21:55 +0800, Dennis Wronka wrote:
> Hi folks,
> 
> I'd like to ask about a problem I am experiencing with newrole.
> When I use newrole in permissive-mode I have no problems changing the role. 
> Also I don't get any audit-messages.
> But when I switch to enforcing-mode I cannot use newrole, it keeps telling 
> me "incorrect password for root", although it clearly is correct.
> I suspect a problem in interaction between newrole and unix_chkpwd, but am not 
> entirely sure about it.
> 
> Problem is that I don't get any audits from SELinux, only errors in auth.log 
> from unix_chkpwd:
> check_pass; user unknown
> password check failer for user (root)
> 
> I am working with the latest reference-policy, adjusted here and there to fit 
> the needs of my distro.
> 
> Thanks for any suggestions.

What version of pam are you using?  What distro?
There were changes made to pam_unix and unix_chkpwd for selinux.
Also, how are you building newrole?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
