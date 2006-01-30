Message-ID: <43DE6244.5010100@cornell.edu>
Date: Mon, 30 Jan 2006 14:00:20 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>
Subject: Desktop integration
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi, my new project (part of it anyway) is to work on desktop 
integration, particularly nautilus and openoffice. We want to display 
(parts of) the security context, and make them configurable by the user. 
Specifically, we're thinking about exposing the type field, and the MCS 
field.

However I am still not happy with the infrastructure we have to support 
that kind of thing, so I wanted to see what others think about this.

The read interface will be easy (hopefully), but the write interface is 
not clear. I think we want to aim for user-friendly selinux. For 
categories, one possibility is to enumerate the translation strings from 
setrans.conf, and have checkboxes for each that the user can click (I 
like this idea). Another way to deal with this is a text box, where we 
can enter translated or untranslated categories and/or ranges.

For the type field, it makes sense to me to have a drop-down box with 
the customizable types in there (as the user shouldn't relabeling to any 
other types). I also think we should translate those types into 
something more user friendly, possibly in multiple languages. I imagine 
a box that you can choose from "Office Document", "Music File", "Image 
FIle", "Sensitive Data", "Untrusted Content", things like that. Any 
other suggestions?

Maybe the nautilus/GNOME list would be a better place to discuss some of 
those things, but I am also interested in the infrastructure that we'll 
need. What needs to be added, and which libraries should it go to? I 
like the idea of making enhancements to libsetrans. Why doesn't this 
library have a clear API with namespace and headers? Will I need to 
replicate my database_file.c code in there? I think we need a way to 
enumerate setrans entires (other than the python semanage utility), 
enumerate customizable types, and translate customizable types.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
