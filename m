MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: UNCLASSIFIED - Clarification of Symlink labelling...
Date: Fri, 25 Jan 2008 19:00:03 -0000
Message-ID: <7F6B06837A5DBD49AC6E1650EFF5490601C64C0F@auk52177.ukr.astrium.corp>
From: "HAWKER, Dan 2 \(external\)" <Dan.HAWKER@uk4.astrium.eads.net>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



> By default, newly created files inherit their type from the 
> parent directory.  Type transition rules in the policy can be 
> used to alter this behavior based on the creating domain, the 
> parent directory type, and the class of file.
> 
> The file contexts configuration (.fc files) is used by 
> programs like rpm to define the initial label to apply when 
> installing a file and by programs like restorecon to restore 
> files to the original install-time label.  But it doesn't 
> affect labeling of files created at runtime by ordinary 
> programs (e.g. running ln -s is just going to leave the 
> symlink in the parent directory's type or whatever type is 
> defined by the applicable type transition rule).
> 
> What you could do is run restorecon on the symlinks in the 
> %post scriptlet of your spec file if you truly want them to 
> be labeled differently.
> 
> But allowing read access to lib_t:lnk_file is generally 
> harmless if you want to just permit it to your domain.
> 

Hi Stephen,

Thanks for that, that makes a lot more sense. I'll have a look at the
rpm spec file and see what happens at the moment (still a work in
progress), but if allowing lib_t:lnk_file is relatively harmless that'll
probably the direction I'll go, at least initially.

Thanks again and have a good weekend.

Dan

--

Dan Hawker
Linux System Administrator
Astrium
http://www.astrium.eads.net

-- 

This email (including any attachments) may contain confidential and/or
privileged information or information otherwise protected from disclosure.
If you are not the intended recipient, please notify the sender
immediately, do not copy this message or any attachments and do not use it
for any purpose or disclose its content to any person, but delete this
message and any attachments from your system. Astrium disclaims any and all
liability if this email transmission was virus corrupted, altered or
falsified.
---------------------------------------------------------------------
Astrium Limited, Registered in England and Wales No. 2449259
REGISTERED OFFICE:-
Gunnels Wood Road, Stevenage, Hertfordshire, SG1 2AS, England


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
