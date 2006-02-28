Message-ID: <44047455.4010601@cornell.edu>
Date: Tue, 28 Feb 2006 11:03:33 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Chad Hanson <chanson@TrustedCS.com>, joe@nall.com,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        SELinux List <SELinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Context translation and MLS categories
References: <4403E1A0.8030704@cornell.edu> <1141132115.22297.158.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1141132115.22297.158.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>>
>> That still leaves translation to be done... but libselinux does not 
>> provide any API for doing translation at the level of an mls range, or 
>> even an individual (sensitivty, category) pair. It only allows 
>> translation at the context level. Why is translation done at the context 
>> level, and can I add additional APIs to translate at mls_range, or 
>> individual sensitivity/category level. How does this affect the MITRE 
>> translation library that I've been hearing about?
>>     
>
> Translation at the entire context level was just for maximal generality
> (and consistent with the general goal of encapsulating the context as
> much as possible), but in practice, only the MLS component is being
> translated presently.  Exporting APIs from libsetrans
Should I be exporting APIs from libsetrans... or from libselinux using 
libsetrans?

>  for translation of
> the range should be fine, IMHO.  Be careful to not misunderstand the
> structure of a MLS range/level though, e.g. s0:c0,c1,c3,c7 has to be
> interpreted as a whole, not as a list of pairs, for the full encoding
> scheme used by the MITRE library, 
Translation aside, this is a list of pairs from an enforcement 
perspective, is it not?
Maybe I'm confused about this, I haven't looked at MLS in detail yet...

=====
How do I tell if s0:c0,c1,c3,c7 is translated as a whole or a list of 
parts. If it's translated as a list of parts, which libsetrans later 
concats using some kind of separator (but are logically independent), I 
want to know what those parts are, and I want them each on a separate 
like in nautilus. If it's interpreted as a whole, then I only want the 
final result. How can I tell? Should I be editing the resultant string? 
What do I present to the user if they want their file accessible by 
s0:c0, and s0:c3, but not the other two.

Also, it seems like the translation is possibly non-unique. If there are 
translation strings for s0:c0,c1, and s0:c3,c7, why are those overridden 
to give precedence to s0:c0,c1,c3,c7. What kind of sorting is applied to 
setrans.conf? Does this make sense in the nautilus case?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
