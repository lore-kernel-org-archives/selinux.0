Message-ID: <4404BA44.8000503@cornell.edu>
Date: Tue, 28 Feb 2006 16:01:56 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>
Subject: Desktop Integration Take 2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Okay, after discussing various obstacles, I think it's time to come up 
with a new plan for integrating selinux w/ nautilus.
How about the following:

- Have a file controlled by libsetrans which maps customizable types to 
(unicode?) translated strings
- Have a file controlled by libsetrans which maps mls ranges to 
(unicode?) translated strings
     (setrans.conf)

- Require the mappings above to be 1:1.

- Have two functions (with better names):
get_customizable_types_by_user()
get_mls_labels_by_user()

The first takes a [Unix] user, and returns the translated labels of all 
customizable types accessible { relabelto } from that user.
The second takes a [Unix] user, and returns the translated labels of all 
mls ranges accessible from that user, [ only the labeled ones ].

===========
Make nautilus link to libsetrans.

Then on startup, nautilus calls both of those functions exactly once.
Then it has an enumeration to work with in set interfaces - have a 
drop-down box for the type, and drop-down box for the mls range.
To label a file to a non-customizable context, add a "Restore Context" 
button, which runs restorecon.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
