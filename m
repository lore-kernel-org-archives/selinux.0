Message-ID: <453789A0.8090105@redhat.com>
Date: Thu, 19 Oct 2006 10:20:16 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: abcde efghi <svmdcv@gmail.com>
CC: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: rpm throws error with selinux enabled
References: <6a9b0ede0610100416oa82aaf7t79a76ec935dd20ce@mail.gmail.com>
In-Reply-To: <6a9b0ede0610100416oa82aaf7t79a76ec935dd20ce@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

abcde efghi wrote:
> on rhel4 u3 x86_64 2.6.9-34.ELsmp kernel , when selinux is enabled, rpm
> installation gives the error:
> 'scriptlet failed, exit status 255'
>
> The default selinux settings are used
> #cat /etc/sysconfig/selinux
> SELINUX=enforcing
> SELINUXTYPE=targeted
>
> e.g. on installing asm rpms:
> # rpm -ivh *.rpm
> Preparing...                ###########################################
> @ [100%]
> @    1:oracleasm-support      ###########################################
> 33%
> error: %post(oracleasm-support-2.0.2-1.x86_64) scriptlet failed, exit 
> status
> 255
>    2:oracleasm-2.6.9-34.ELsm###########################################
> 67%]
> error: %post(oracleasm-2.6.9-34.ELsmp-2.0.2-1.x86_64) scriptlet 
> failed, exit
> status 255
>    3:oracleasmlib           ##########################################
> [100%]
> .
> However, asm rpms gets installed
> # rpm -qa | grep asm
> oracleasm-support-2.0.2-1
> oracleasmlib-2.0.2-1
> oracleasm-2.6.9-34.ELsmp-2.0.2-1
>
> any help most welcome
>
This type of question is better off asked on the fedora-selinux list.  
If you are using Fedora :^)
Are you seeing any AVC messages in /var/log/messages?  What policy 
version are you running?

> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
