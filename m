Message-ID: <4AC26E8F.8010308@redhat.com>
Date: Tue, 29 Sep 2009 16:31:11 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: Configuring libsemanage to invoke a policy checker
References: <1254253967.2252.232.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1254253967.2252.232.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 09/29/2009 03:52 PM, Stephen Smalley wrote:
> This came up as a question at the SELinux summit, so I thought I'd also
> post the answer on the list since it is a largely undocumented feature.
> If you want libsemanage to invoke a program to check a policy for some
> property before allowing it to be installed and loaded, then you can
> configure libsemanage as follows.
> 
> Add the following lines to your /etc/selinux/semanage.conf file:
> [verify kernel]
> path = /usr/bin/mypolicychecker
> args = $@
> [end]
> 
> Then create /usr/bin/mypolicychecker, e.g.:
> #!/bin/sh
> ls -l $1
> exit 0
> 
> chmod +x /usr/bin/mypolicychecker
> 
> Subsequent semodule or semanage commands will trigger its execution,
> passing it the path to the kernel policy file in the sandbox before
> installing it. If it returns non-zero, the transaction will abort and
> roll back.
> 
> Obviously you would replace mypolicychecker with an actual program that
> applies some set of checks to the policy and exits with an appropriate
> error status based on whether the checks passed.
> 
> There is also a variant for running a policy checking program on each
> individual module ([verify module]) but I'm not sure how useful that
> would be.
> 
So a better example might be you want to guarantee that no one can write to a shadow_t

#!/bin/sh
domain_ctr = `sesearch --allow -t shadow_t -c file -p write $1 | wc -l`
if [ $domain_ctr != 10 ]; then 
    exit 1
fi
exit 0



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
