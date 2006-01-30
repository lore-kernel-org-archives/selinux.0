Message-ID: <43DE6578.9050302@redhat.com>
Date: Mon, 30 Jan 2006 14:14:00 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: Desktop integration
References: <43DE6244.5010100@cornell.edu>
In-Reply-To: <43DE6244.5010100@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
> Hi, my new project (part of it anyway) is to work on desktop 
> integration, particularly nautilus and openoffice. We want to display 
> (parts of) the security context, and make them configurable by the 
> user. Specifically, we're thinking about exposing the type field, and 
> the MCS field.
>
> However I am still not happy with the infrastructure we have to 
> support that kind of thing, so I wanted to see what others think about 
> this.
>
> The read interface will be easy (hopefully), but the write interface 
> is not clear. I think we want to aim for user-friendly selinux. For 
> categories, one possibility is to enumerate the translation strings 
> from setrans.conf, and have checkboxes for each that the user can 
> click (I like this idea). Another way to deal with this is a text box, 
> where we can enter translated or untranslated categories and/or ranges.
seobject.py currently does this, but of course it is written in python.

It basically does a getcon on the process and then takes it MLSRange 
potion and translates it into reachable contexts

s0-s0:c1.c5  = s0. s0:c1, s0:c2, s0:c3, s0:c4, s0:c5. 

It then attempts to translate each one of these to show the user which 
categories he can create files in.
>
> For the type field, it makes sense to me to have a drop-down box with 
> the customizable types in there (as the user shouldn't relabeling to 
> any other types). I also think we should translate those types into 
> something more user friendly, possibly in multiple languages. I 
> imagine a box that you can choose from "Office Document", "Music 
> File", "Image FIle", "Sensitive Data", "Untrusted Content", things 
> like that. Any other suggestions?

>
> Maybe the nautilus/GNOME list would be a better place to discuss some 
> of those things, but I am also interested in the infrastructure that 
> we'll need. What needs to be added, and which libraries should it go 
> to? I like the idea of making enhancements to libsetrans. Why doesn't 
> this library have a clear API with namespace and headers? Will I need 
> to replicate my database_file.c code in there? I think we need a way 
> to enumerate setrans entires (other than the python semanage utility), 
> enumerate customizable types, and translate customizable types.


Changing types is a tougher problem.  First you are making two bad 
assumptions.

1. That a user can relabel to all of the customizable types.  In most 
policies he will not be allowed to .

2. That the only types he can relabel to are customizable.

For  example user_home_t is not necessarily customizable but a user 
could change a context to it.

Until we get a better interface I think you have at best the option to 
allow the user to

Restore System Defaults on a file (Restorecon)

Or prompt them for the context they want to change to.

We could make an assumption that httpd_user_* are available options 
since this would seem to be the most likely context a user would want to 
set.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
