Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4NBRZI4026531
	for <selinux@tycho.nsa.gov>; Fri, 23 May 2003 07:27:35 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4NBRAuO004085
	for <selinux@tycho.nsa.gov>; Fri, 23 May 2003 11:27:10 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h4NBR9lV004082
	for <selinux@tycho.nsa.gov>; Fri, 23 May 2003 11:27:09 GMT
Subject: Re: about security contexts for objects
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Giorgio Zanin <selinux_list@yahoo.it>
Cc: Russell Coker <russell@coker.com.au>, selinux@tycho.nsa.gov
In-Reply-To: <3ECDD727.7030905@yahoo.it>
References: <3ECCDA52.5010802@yahoo.it>
	 <200305230235.50512.russell@coker.com.au>
	 <1053631371.1032.43.camel@moss-huskers.epoch.ncsc.mil>
	 <3ECDD727.7030905@yahoo.it>
Content-Type: text/plain
Message-Id: <1053689210.1082.1.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 23 May 2003 07:26:50 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-05-23 at 04:09, Giorgio Zanin wrote:
> Stephen Smalley wrote:
> >>Not all of them.  The file_type attribute is limited to files associated
> >>with conventional (disk-based) filesystems and is used in allow rules
> >>permitting the association of such types with those filesystems.  It
> >>doesn't cover types associated with pseudo filesystems.
> >>
> what are exactly all the kinds of pseudo files? Do they cover every  
> object class  other than  file-related ones (file, filesystem, dir, 
> fifo_file, ...) and process?

No.  Pseudo files (e.g. /proc entries, devpts entries) have one of the
file classes.  So your approach of checking all allow rules that involve
a file class will capture these kinds of files as well as conventional
files, unlike the file_type attribute.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
