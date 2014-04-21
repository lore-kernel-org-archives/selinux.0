Message-ID: <535516B6.4090705@tycho.nsa.gov>
Date: Mon, 21 Apr 2014 09:01:42 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Kernel freak <kernelfreak@gmail.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: Allowing access other then permissive mode.
References: <CAOFt0CQHwubzwGSTsw5ig-1tTG9QJe16X5HFoxgjwvV6_StoaA@mail.gmail.com>
In-Reply-To: <CAOFt0CQHwubzwGSTsw5ig-1tTG9QJe16X5HFoxgjwvV6_StoaA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/19/2014 03:53 PM, Kernel freak wrote:
> Hello friends,
>                     I am starting a new thread to achieve the objective.
> I want to attach my own piece of code wherever SELinux takes access
> decision or Policy decision point. So for example, whenever it queries
> the database to check the rule, I want to return "allowed" everytime
> through code and not by using Permissive mode. It is very important I
> don't use permissive mode.
> 
> My point of confusion is which part of code I should look to see where
> there is a policy decision point where database is queried. As far as I
> understand, a return of '0' means access is allowed. I tried hardcoding
> rc=0 in many situations, but there are a lot of denials I am getting.
> 
> Kindly let me know. Thank you for your time.

Permissive mode still logs the denial even though it does not return an
error to the caller and allows the system call to proceed.  So that is
why you still see avc denial messages even if you return 0 from
avc_denied(), just like permissive mode.

If you want to allow everything with no log messages, then just change
security_compute_av() to just goto allow, where it sets the avd->allowed
vector to all-bits-set (i.e. all permissions granted) and returns.
