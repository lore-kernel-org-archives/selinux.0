Subject: RE: Access to the postgresql data files
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Igor Borisovsky <_bip_@inbox.ru>
Cc: SELinux@tycho.nsa.gov, "'Russell Coker'" <russell@coker.com.au>,
   fedora-selinux-list@redhat.com
In-Reply-To: <200406041502.i54F2Nh16193@alexru.adsl.kis.ru>
References: <200406041502.i54F2Nh16193@alexru.adsl.kis.ru>
Content-Type: text/plain
Message-Id: <1086362064.19959.206.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 04 Jun 2004 11:14:25 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-06-04 at 10:59, Igor Borisovsky wrote:
> Thanks for reply.
> Let me explain in more details my problem.
> I have the database server under RedHat9.
> The postgresql database contains very important secure data.
> So nobody should have access to this data directly.
> Only authorized clients via SSL connections should have access.
> In the ordinary linux user root can steal postgresql data files or
> edit pg_hba.conf file to give access to itself.
> Thus I want to use FC2 to control access to data files for user root.
> User root should be only linux server administrator. For example, root
> should be able to create/delete user, install software/hardware, start/stop
> services. But root must not have access to postgresql files.

You can use SELinux to ensure that only certain applications have direct
access to the files.  But if root can install software, then he can just
replace those applications with his own code to get access to the
files.  Or he can replace any code or configuration on which those
applications depend, e.g. the kernel, ld.so, whatever.  And if there is
any user account which is authorized to access those files and you let
root manage user accounts, then root can gain access to those accounts. 
Not to mention issues of raw disk access, whether direct or indirect via
filesystem administrative utilities.  See the problem?  So you would
have to strip root of _many_ typical administrative privileges to truly
enforce such a guarantee.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
