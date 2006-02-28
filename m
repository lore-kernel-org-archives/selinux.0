Message-ID: <4403E1A0.8030704@cornell.edu>
Date: Tue, 28 Feb 2006 00:37:36 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>
Subject: Context translation and MLS categories
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

To integrate selinux with nautilus, I'd like to have a function which 
provides me with a list of translated (sensitivity, category) pairs, as 
setrans.conf specifies. Then I can present a list of those strings to 
the user.

The question is...where should this function be located, and what kind 
of API will it have?

Currently I have a raw context that is supplied by gnome-vfs. Clearly I 
need to break that down into fields. I want the user to configure the 
individual fields, not have a box to type in the context. This breakdown 
seems like it should be internal to selinux libraries. A good place to 
do it is in the sepol context record. However, currently libsepol is 
completely unaware of translations - all it can do is supply the raw mls 
range, or possibly expand the mls range into some other format - like a 
list of (sens, cat) pairs.

That still leaves translation to be done... but libselinux does not 
provide any API for doing translation at the level of an mls range, or 
even an individual (sensitivty, category) pair. It only allows 
translation at the context level. Why is translation done at the context 
level, and can I add additional APIs to translate at mls_range, or 
individual sensitivity/category level. How does this affect the MITRE 
translation library that I've been hearing about?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
