Subject: Re: Content macros v 2 (create implies read in policy)
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: SELinux <SELinux@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1118855232.25735.10.camel@celtics.boston.redhat.com>
References: <1118744201.3416.13.camel@localhost.localdomain>
	 <1118770918.7853.5.camel@celtics.boston.redhat.com>
	 <1118855232.25735.10.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Wed, 15 Jun 2005 15:38:38 -0400
Message-Id: <1118864318.25735.43.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> The other major thing that doesn't work is printing
> if read_APP_content or read_untrusted is disabled.
> I need to investigate how printing is done to get
> this working. In particular, why isn't lpr
> reading the document, instead of APP. If lpr
> was reading the document, we could add a print_untrusted boolean
> to lpr that's different from read_untrusted_content.

So, here's an outline of the problem.

CHANGES:
=========
I've done two things in the content macros that might be of interest,
because they break stuff.

1) I've broken the assumption that create implies read. 
If you look at the write_* macros, you will see that the new
versions I added are specifically written to disallow read.
I was actually surprised to see that create implies read
everywhere, and there's not even a macro for write-only.
I added a new core macro called create_noread_file_perms.

2) if you look at the read_content macro, you will see
that the read_untrusted_content boolean has no effect
if the read_APP_content boolean is present, and false.
What this means is - I can prevent an application from
reading any content, whether it's trusted, or not. 
The booleans stack.

Now, those two things make sense to me, but at the same time break
printing.

BOOLEAN STATE:
==============
Now assume the following state of booleans:

mozilla_read_content is off - this indicates that mozilla
has no business reading my private files, trusted or not

mail_read_content is off - this indicates evolution/t-bird
can't read my private files, trusted or not

read_untrusted_content is on - this indicates that 
the applications that are allowed to read content, can
also read untrusted content. This is the likely state
of that boolean for now, lacking any sort of conversion
mechanism at this point, other than chcon to
change content from untrusted to trusted. This 
needs to change in the future to something
more user friendly, or this whole untrusted
business will be of limited use.

write_untrusted_content is on - this indicates
that applications that try to write untrusted
content are allowed to do so.

THE PROBLEM:
============
Now, lpr, being a somewhat trusted application, can read content,
without a controlling boolean, so that it can print it out.
Since I've also allowed reading untrusted content, it
should be able to print my file.

Mozilla/evolution is also allowed to write that file to disk.

What's broken is the part where mozilla/evolution read
the untrusted content back in. I'm not sure why they do this.
There's speculation that they do this, in order to concaternate 
the file itself, with header data. That part is disallowed, 
because those apps can't read *any* content. I've decided 
to do away with the capability of reading content for the 
purpose of uploading it to forms, for using it as attachments... 
it's a download only stream, with this particular configuration.

POSSIBLE SOLUTIONS:
===================

0) Fix apps so they do this printer manipulation in
their private folders, whether that's in $HOME or in /tmp.
This requires changing the application code, which is unfortunate.
I have to investigate whether this is library code or not.
If the folder is in /tmp, it might require pre-creating more
folders with a script (or alternative mechanism, when implemented).

1) Stop trying to change the assumption that create implies read,
and grant back this privilege to mozilla. This, however, subverts
read content booleans. Now mozilla can read untrusted content,
by write implies read. Being untrusted does not mean unimportant. 
It means it's data that originated from the web, that hasn't 
been processed in any way to make it trusted. Consider saved mail,
saved by evolution, currently marked untrusted. Now mozilla
can read your mail, even though you *specifically* disabled
the read_mozilla_content boolean. Say solution 1 ignores this problem. 

2) Stop trying to change the assumption that create implies
read, and at the same time create further separation of
content, beyond trusted and untrusted (as in...your saved mail
is not the same thing as saved webpages, and mozilla
has no business reading your mail). We might want to do
that in the distant future anyway, regardless of this problem.
Alter the content macros to deal with this improved level of
granularity. 

Any opinions, on which option is best, or anything else?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
