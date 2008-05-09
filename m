Subject: Re: Compat_net an pam login problem.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Scally, Katrina-P54861" <Katrina.Scally@gdc4s.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <2B0195B08BA41748A38C4D58ADF44F2C02654731@AZ25EXM01.gddsi.com>
References: <2B0195B08BA41748A38C4D58ADF44F2C02654731@AZ25EXM01.gddsi.com>
Content-Type: text/plain
Date: Fri, 09 May 2008 13:40:11 -0400
Message-Id: <1210354811.6434.233.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-05-09 at 09:51 -0700, Scally, Katrina-P54861 wrote:
> I am logging in via console, what I have found is this: 
> I have selinux_compat_net=1 in my grub.conf file. If I remove this 
> from the file I can indeed login with the latest reference policy and 
> pam-0.1.99.6.2-3.26.el5.i386.rpm. 
> But I, of course, need to use legacy packet control. I have been 
> searching around online and see that I can bypass doing this at boot 
> and possibly set compat_net at runtime. I am wondering why having
> this 
> on boot would cause login problems, I don't see the connection. 
> I am trying to see if I have the same problem when I set compat_net 
> during runtime.

compat_net can be set at runtime by writing to /selinux/compat_net, e.g.
	echo 1 > /selinux/compat_net

The login problem suggests that you are encountering some kind of
network permission denial during the login sequence, like attempting to
perform a LDAP or NIS lookup of the user.

If you aren't seeing any avc messages in /var/log/audit/audit.log
or /var/log/messages, you may want to strip dontaudit rules from your
policy and try again.  semodule -DB will do that for you if you have a
recent enough version of policycoreutils; if not, then you can always
build your policy with dontaudit rules stripped via make enableaudit.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
