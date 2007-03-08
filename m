Message-ID: <45F035D2.9030307@redhat.com>
Date: Thu, 08 Mar 2007 11:12:02 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Minor change to getsebool.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Should be non fatail when executing getsebool -a.  I am starting to 
label the booleans and
different user roles will only be able to manipulate certain booleans.

So we need to change

getsebool -a will only show booleans that domain can manipulate.
Currenly it will report the errrors that it can not read.  We can either 
add a qualifier to silence these or a new option to get only the list of 
the ones I can manipulate.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
