Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4N8CsI4026026
	for <selinux@tycho.nsa.gov>; Fri, 23 May 2003 04:12:54 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4N8CTuO028389
	for <selinux@tycho.nsa.gov>; Fri, 23 May 2003 08:12:29 GMT
Received: from venere.mat.uniroma1.it ([151.100.50.3])
	by jazzswing.ncsc.mil  with ESMTP id h4N8CSlV028373
	for <selinux@tycho.nsa.gov>; Fri, 23 May 2003 08:12:29 GMT
Message-ID: <3ECDD727.7030905@yahoo.it>
Date: Fri, 23 May 2003 10:09:11 +0200
From: Giorgio Zanin <selinux_list@yahoo.it>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Russell Coker <russell@coker.com.au>, selinux@tycho.nsa.gov
Subject: Re: about security contexts for objects
References: <3ECCDA52.5010802@yahoo.it>	 <200305230235.50512.russell@coker.com.au> <1053631371.1032.43.camel@moss-huskers.epoch.ncsc.mil>
In-Reply-To: <1053631371.1032.43.camel@moss-huskers.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>>Look at the policy for all types that have the attribute file_type, that 
>>should catch all of them.
>>

Actually file_type, as it is just an attribute with no semantics with 
respect to the configuration language, is not the thing I would look at.
I mean, attributes are just names associated with types with no 
semantics from a language point of view. What I need is something with 
semantics in the configuration language context.
I wouldn't use attributes values fot infering any property of a 
configuration, becouse I can think at an attribute just as a collection 
of types (attributes are useful but they are not necessary).

>>Not all of them.  The file_type attribute is limited to files associated
>>with conventional (disk-based) filesystems and is used in allow rules
>>permitting the association of such types with those filesystems.  It
>>doesn't cover types associated with pseudo filesystems.
>>
what are exactly all the kinds of pseudo files? Do they cover every  
object class  other than  file-related ones (file, filesystem, dir, 
fifo_file, ...) and process?

Giorgio



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
