Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t1KNcWvf002310
 for <selinux@tycho.nsa.gov>; Fri, 20 Feb 2015 18:38:32 -0500
Received: by qcrw7 with SMTP id w7so3369850qcr.4
 for <selinux@tycho.nsa.gov>; Fri, 20 Feb 2015 15:38:31 -0800 (PST)
Message-ID: <54E7C574.6020605@quarksecurity.com>
Date: Fri, 20 Feb 2015 18:38:28 -0500
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: Tracy Reed <treed@ultraviolet.org>
Subject: Re: MCS error
References: <20150219014803.GB12937@tracyreed.org>
 <54E5E3C4.40904@tycho.nsa.gov>
 <20150219154047.GA11807@linksys-wireless-usb.network2>
 <20150219193337.GC12937@tracyreed.org>
 <20150219204841.GA1649@linksys-wireless-usb.network2>
 <20150220003425.GF12937@tracyreed.org> <20150220020213.GG12937@tracyreed.org>
 <20150220073302.GA10579@linksys-wireless-usb.network2>
 <20150220232749.GM12937@tracyreed.org>
In-Reply-To: <20150220232749.GM12937@tracyreed.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Tracy Reed wrote:
> On Thu, Feb 19, 2015 at 11:33:03PM PST, Dominick Grift spake thusly:
>> Right, this table (login table) shows the associations of selinux
>> identities
>> and selinux securtity levels with linux users, whereas the "user
>> table" shows
>> associations of selinux roles and security levels with selinux users.
>
> Ok, I think I understand that now... Looks like they both can associate
> security levels with their respective kinds of users. Seems odd now to
> be able
> to associate security levels with Linux users instead of just SELinux
> users.
>
> Now I am wondering which one takes precedence. For example, in the MCS
> setup I
> am attempting do I need to have the security category defined in the
> login
> table or the user table or both?
>

SELinux users have a strict superset of the levels that Linux users do.

The SELinux kernel policy does not know or care about Linux users. It 
only knows SELinux users, they are defined in the policy and have a set 
of levels associated with them. The tools below adjust those levels as 
they are defined in the kernel binary policy.

Originally there was no Linux user->SELinux user mapping at all, that 
was added so that Linux users didn't need to be added to the SELinux 
binary policy, before these management tools existed.

Nowadays, in the managed policy case, you can associate a subset of the 
levels of an SELinux user to a Linux user. This is enforced by the login 
program and not by the kernel. The kernel will only enforce the SELinux 
user does not gain more levels than assigned in the policy.

Does that make sense?

>> You are misunderstanding the concept of associating things with "selinux
>> users" (user table) versus the concept of associating things with "linux
>> users" (login table), and how the two relate.
>
> Indeed.
>
>> You cannot associate something with a Linux user if that something is
>> not
>> associated with the SELinux user first.
>
> Ok...
>
>> For example the error message above complains that you have a
>> "appuser_u"
>> identity associated with some "linux user(s)" (p16002, p16003).
>> Howver that
>> identity (appuser_u) does not exist in your "user table".
>>
>> So to fix that error: re-add the appuser_u selinux user to the "user
>> table" ,
>> then remove the references to "appuser_u" from the "login table"
>> *first* ,
>> and then finally remove the appuser_u association from the "user table"
>> again.
>
> Your use of "*first*" in the second step is confusing to me but it
> looks like
> the order of operations here is:
>
> 1. re-add the appuser_u selinux user to the "user table"
>
> 2. remove the references to "appuser_u" from the "login table"
>
> 3. remove the appuser_u association from the "user table"
>
>
> So to do step 1 and re-add appuser_u selinux user to the "user table"
> I should do this and get this result:
>
> # semanage user -a -R user_r appuser_u
> libsemanage.validate_handler: selinux user appuser_u does not exist
> (No such file or directory).
> libsemanage.validate_handler: seuser mapping [p16002 -> (appuser_u,
> s0:c1.c499-s0:c2)] is invalid (No such file or directory).
> libsemanage.dbase_llist_iterate: could not iterate over records (No
> such file or directory).
> /usr/sbin/semanage: Could not commit semanage transaction
>
> Even if I try step 2 first (in case that's what you meant by *first) I
> get this:
>
> # semanage login -d p16002
> libsemanage.validate_handler: selinux user appuser_u does not exist
> (No such file or directory).
> libsemanage.validate_handler: seuser mapping [p16003 -> (appuser_u,
> s0:c1.c499-s0:c3)] is invalid (No such file or directory).
> libsemanage.dbase_llist_iterate: could not iterate over records (No
> such file or directory).
> /usr/sbin/semanage: Could not commit semanage transaction
>
> What am I missing here? Thanks!
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
