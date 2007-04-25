Subject: Re: cannot login using strict policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: JanuGerman <doublemalam@yahoo.co.uk>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <706356.14667.qm@web86906.mail.ukl.yahoo.com>
References: <706356.14667.qm@web86906.mail.ukl.yahoo.com>
Content-Type: text/plain
Date: Wed, 25 Apr 2007 11:44:40 -0400
Message-Id: <1177515880.24282.223.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-04-25 at 15:31 +0000, JanuGerman wrote:
> Hi Karl,
> 
> Thanks for the response. I have to reboot with 'selinux=0' in order to
> diagnose the type of .bash_profile. It is
> 'root:object_r:user_home_t:s0'. This seems to me a problem, like every
> time, i will have to reboot with selinux=0, in order to get the
> attributes of the file. Plus one question regarding the unconfined_t.
> Is unconfined_t is changed to confined_t in strict policy mode?

You should just be able to boot with enforcing=0, not selinux=0.  Or
even switch to permissive via setenforce 0 if you can login at least on
the console and newrole -r sysadm_r.

Under strict policy, users run in confined domains like user_t and
staff_t, and the user must newrole -r sysadm_r to enter the admin role.

The /root files should be labeled with sysadm_home_t, not user_home_t.
Look at /etc/selinux/strict/contexts/files/file_contexts.homedirs for
the /root entries.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
