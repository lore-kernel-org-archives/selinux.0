Subject: Re: implementation of conditional policies
From: Stephen Smalley <sds@tycho.nsa.gov>
To: JanuGerman <doublemalam@yahoo.co.uk>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <632374.50812.qm@web86903.mail.ukl.yahoo.com>
References: <632374.50812.qm@web86903.mail.ukl.yahoo.com>
Content-Type: text/plain
Date: Mon, 02 Apr 2007 08:51:08 -0400
Message-Id: <1175518268.5889.6.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-04-02 at 10:51 +0000, JanuGerman wrote:
> Hi,
> 
> Sorry for this inconvenience. Unfortunately, the problem is still not solved. I relabeled the file /etc/medicalpolicy to 
> 
> root:object_r:testfile_t and removed it from the home directory of the root.
> 
> the configuration of the refpolicy are:
> 
> --myapp.fc
> /etc/medicalpolicy  -- gen_context(root:object_r:testfile_t)
> and
> --myapp.te
> policy_module(myapp,1.0)
> # Private type declarations
> require {
>         attribute domain;        
> }
> #type user_home_t;
> #type bin_t;
> #type myapp_t;
> type testfile_t;
> files_type(testfile_t);
> bool test false;
> if (test) {
>     allow domain testfile_t:file {read};
>     }
> 
> 
> As you mentioned, about the use of strict policy and targeted policy, but when i change the option in the /etc/selinuc/config to strict, to see a chance to get effect of it, at the restart, kernel panics and says selinux is in enforcing mode.....kernel panics....
> 
> Perhaps the sources of strict policy are not installed?. Or this kind of policy is not enforced, in the targeted mode of operation of SELinux. any Idea?

Under targeted policy, the unconfined_t domain can access all file
types, so putting that testfile_t type on the file only limits the
ability of confined domains (like httpd_t) to access it; it doesn't
affect anything running in unconfined_t.

To convert to strict policy, you have to install it, e.g.
	yum install selinux-policy-strict
then set /etc/selinux/config to refer to it.  On the initial conversion,
I'd recommend booting with "enforcing=0 single" and running fixfiles
relabel to make sure your filesystem is properly labeled for the strict
policy.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
