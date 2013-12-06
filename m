Message-ID: <52A1DBA8.2050708@redhat.com>
Date: Fri, 06 Dec 2013 09:14:00 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>,
        Dominick Grift <dominick.grift@gmail.com>
CC: Pavel Roschin <roshin@scriptumplus.ru>, selinux@tycho.nsa.gov
Subject: Re: avtab dense hash table
References: <20131205130431.7fe3c727.roshin@scriptumplus.ru>		 <52A08A87.2030009@tycho.nsa.gov> <1386258595.2469.18.camel@d30>	 <52A0ED28.6050804@tycho.nsa.gov> <1386279472.2469.51.camel@d30> <52A1D65C.3070607@tycho.nsa.gov>
In-Reply-To: <52A1D65C.3070607@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/06/2013 08:51 AM, Stephen Smalley wrote:
> On 12/05/2013 04:37 PM, Dominick Grift wrote:
>> Thanks, But if i understand it correctly then types that have (roughly) 
>> the same properties would be candidates for merger.
> 
> That's correct.  Domains/types are intended to be security equivalence 
> classes; all subjects that require the same accesses to the same objects 
> should be in the same domain and all objects that need to be accessed 
> identically by the same subjects should be in the same type.  It wasn't 
> supposed to be one domain for every program executable or one type for 
> every directory/file.
> 
>> That could be processes (or files) with different properties ( but same 
>> rules associated with them )
>> 
>> That would mean that a system could end up with various different 
>> processes running in the same domain (thus they can in theory affect each
>> other)
>> 
>> The way i am approaching it is besides requiring types to have similar 
>> properties that also the processes have similar properties
>> 
>> So for example merge all web servers if the policy is roughly the same.
>> 
>> My reasoning for this is that only one kind of web server runs on a 
>> system at any given time (usually).
>> 
>> Another example all: all irc clients in the same domain because often one
>> kind of irc client is used on a system at any given time
> 
> Exactly, and if you still want to isolate the different instances from each
> other, you can use category sets more effectively for that purpose than
> needing to define separate domains/types.
> 
>> I see that you are willing to take this further. If for example (stupid 
>> example) a mail server would have the same properties (rules) as a web 
>> server that would be a candidate for a merger. Even though the mail 
>> server and the web server could run on a system at any given time. Thus 
>> they could affect each other
>> 
>> For android that approach would work since seandroid also associates 
>> unique categories to uids but this does not apply to regular Linux
> 
> Well, at least in mainline Android, we had to back off of per-app category
> sets because Android does permit direct app interactions.  But the
> category-based separation can still be applied at differing granularities,
> from per-app to per-user (Android now supports multi-user) to per-container
> (e.g. personal/business separation), based on your specific policy
> configuration.
> 
>> Would you agree that a system like Fedora has different properties than a
>> system like seandroid?
>> 
>> It occurs to me that Fedora is much more general purpose whereas android 
>> is a phone operating system.
> 
> I certainly agree that they differ, and that Android is much easier to 
> construct a policy for.  That said, there does seem to be increasing 
> convergence and many of the same techniques can be applied, e.g. 
> category-based separation has already been effectively applied in Fedora 
> for sandbox, svirt, OpenShift, and others.
> 
>> I believe that there is a lot of room for improvement in reference policy
>> and i am willing to do the leg work to bring some change in this regard.
>> Consensus is not easy to achieve though. I could not even make the case
>> for getting nginx in the apache domain.
> 
> It may be necessary to fork a separate policy, at least for a while, to 
> truly explore more radical surgery, and then try to gradually feed the 
> changes back.
> 
>> I hope that this thread can get a discussion going with regard to 
>> simplifying the policy without compromising too much
>> 
>> Thank you for you reply
> 
> -- This message was distributed to subscribers of the selinux mailing
> list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without quotes
> as the message.
> 

We have been doing some consolidation in Fedora.  We have combined spam tools
into a single domain spamassassin.  Might have been better to create a new
policy for this.

We have also created antivirus which combined all of the antivirus tools.

The next big one I would like to see combined are mail servers and mail
clients.  (Elimination of all the different postfix domains, would eliminate
large numbers of bugs over the years.)


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKh26gACgkQrlYvE4MpobPzSQCg6E2BpD9CWfPU9q84+U8kPQs9
qi4AoInIXDi4u2I5x9HM3patjyJdVrH5
=sAud
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
