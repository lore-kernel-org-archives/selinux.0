Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2TEJELI031511
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2007 10:19:14 -0400
Received: from web86902.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l2TEJBAB017021
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2007 14:19:12 GMT
Date: Thu, 29 Mar 2007 15:19:10 +0100 (BST)
From: JanuGerman <doublemalam@yahoo.co.uk>
Subject: Re: Conditional Policy using Reference Policy
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1175172393.13607.2.camel@sgc.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <319917.38164.qm@web86902.mail.ukl.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks.


> Since you are trying to make a type for a file, you
> would want
> file_type() instead of domain_type().

file_type is not working and giving the following
error message:

myapp.te:6:ERROR 'syntax error' at token 'file_type'
on line 77316:
file_type(testfile_t);

I removed this statement, and compiled the module
successfuly and now the boolean variable appears in
the  /selinux/booleans/. 

"cat" command shows that the value of the boolean
variable is "0 0", but still any applicaiton/binary
e.g. "vi" can access it, although the boolean variable
is false. I was not able to solve this, does this
means that the default context set for the file and
for the binaries/applications take precedence? 

I have already set the context of the file in the
myapp.fc


Best,
JG





		
___________________________________________________________ 
The all-new Yahoo! Mail goes wherever you go - free your email address from your Internet provider. http://uk.docs.yahoo.com/nowyoucan.html

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
