Message-ID: <49BAFBF8.8070805@martinorr.name>
Date: Sat, 14 Mar 2009 00:36:08 +0000
From: Martin Orr <martin@martinorr.name>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Paul Cocker <paul.cocker@tntpost.co.uk>, selinux@tycho.nsa.gov
Subject: Re: Unable to disable SELinux
References: <DAE2574A7F44F44ABE07381C36213DFA069F7833@exch.cdltd.co.uk> <1236948159.9747.13.camel@localhost.localdomain>
In-Reply-To: <1236948159.9747.13.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 13/03/09 12:42, Stephen Smalley wrote:
> On Fri, 2009-03-13 at 12:25 +0000, Paul Cocker wrote:
>> Running SELinux on a CentOS 5.2 box, Im trying to temporarily disable
>> SELinux via one of the following methods:
>>  
>> 1. sudo echo 0 > /selinux/enforce
> 
> Typically one would run the setenforce 0 command, but that is equivalent
> to what you are doing above.

This isn't true because the redirection will be interpreted by the non-root
shell.  You should either do:
sudo setenforce 0
as Stephen suggests, or if you really want to,
sudo sh -c "echo 0 > /selinux/enforce"

>> 2. sudo vim /selinux/enforce
>>  
>> The first comes back with
>>  
>> -bash: /selinux/enforce: Permission denied
> 
> This means that your SELinux policy prevented you from changing the
> enforcing status.  What context are you operating in (id -Z)?  What
> context is sudo running the command in (sudo id -Z)?

No, I think it is DAC because the shell will attempt to open
/selinux/enforce before running sudo.

Best wishes,

-- 
Martin Orr

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
