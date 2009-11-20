Message-ID: <4B06CB5A.2060400@manicmethod.com>
Date: Fri, 20 Nov 2009 12:01:14 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: Configuring libsemanage to invoke a policy checker
References: <1254253967.2252.232.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1254253967.2252.232.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
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

In case anyone here is interested I've added a document page to the 
selinuxproject wiki with information about the validation hook and with 
an example validator that uses sesearch to ensure no rules allowing 
user_t to access shadow_t are added to the policy. The URL is 
<http://selinuxproject.org/page/PolicyValidate>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
