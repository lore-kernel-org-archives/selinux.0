Subject: Re: Context translation and MLS categories
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Chad Hanson <chanson@TrustedCS.com>, joe@nall.com,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        SELinux List <SELinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <4403E1A0.8030704@cornell.edu>
References: <4403E1A0.8030704@cornell.edu>
Content-Type: text/plain
Date: Tue, 28 Feb 2006 08:08:35 -0500
Message-Id: <1141132115.22297.158.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-02-28 at 00:37 -0500, Ivan Gyurdiev wrote:
> To integrate selinux with nautilus, I'd like to have a function which 
> provides me with a list of translated (sensitivity, category) pairs, as 
> setrans.conf specifies. Then I can present a list of those strings to 
> the user.
> 
> The question is...where should this function be located, and what kind 
> of API will it have?
> 
> Currently I have a raw context that is supplied by gnome-vfs. Clearly I 
> need to break that down into fields. I want the user to configure the 
> individual fields, not have a box to type in the context. This breakdown 
> seems like it should be internal to selinux libraries. A good place to 
> do it is in the sepol context record. However, currently libsepol is 
> completely unaware of translations - all it can do is supply the raw mls 
> range, or possibly expand the mls range into some other format - like a 
> list of (sens, cat) pairs.
> 
> That still leaves translation to be done... but libselinux does not 
> provide any API for doing translation at the level of an mls range, or 
> even an individual (sensitivty, category) pair. It only allows 
> translation at the context level. Why is translation done at the context 
> level, and can I add additional APIs to translate at mls_range, or 
> individual sensitivity/category level. How does this affect the MITRE 
> translation library that I've been hearing about?

Translation at the entire context level was just for maximal generality
(and consistent with the general goal of encapsulating the context as
much as possible), but in practice, only the MLS component is being
translated presently.  Exporting APIs from libsetrans for translation of
the range should be fine, IMHO.  Be careful to not misunderstand the
structure of a MLS range/level though, e.g. s0:c0,c1,c3,c7 has to be
interpreted as a whole, not as a list of pairs, for the full encoding
scheme used by the MITRE library, IIUC.  Joe Nall also recently asked
about extending libsetrans to support inverse bit encodings.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
