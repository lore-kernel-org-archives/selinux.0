MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Linux user / SELinux user changes...
Date: Thu, 21 Jun 2007 21:29:40 -0400
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D03ABC378@de01exm68.ds.mot.com>
In-Reply-To: <1182428692.15064.277.camel@moss-spartans.epoch.ncsc.mil>
References: <1181917726.17547.750.camel@moss-spartans.epoch.ncsc.mil> <1182365766.15064.199.camel@moss-spartans.epoch.ncsc.mil> <20070620201333.GC32520@sergelap.austin.ibm.com> <1182372732.15064.268.camel@moss-spartans.epoch.ncsc.mil> <20070620210835.GA21869@sergelap.austin.ibm.com> <1182428692.15064.277.camel@moss-spartans.epoch.ncsc.mil>
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

 
Hi All,

If I have Linux users "root"  and "test"     and I have
SELinux users  "staff_u", and "user_u",  and 
SELinux roles  "staff_r", and "user_r"  

If I ssh into the Linux machine as test, my SELinux identity is user_u.
If I ssh into the Linux machine as root, my SELinux identity is staff_u.

Lets say I ssh into my Linux machine as Linux user "root".
"id -Z"  shows   staff_u:staff_r:staff_t

Now if I downgrade my Linux user priviledge to user "test" by using  su
as follows:

su - test
Pass: test

id -Z  =>  still shows me that I am staff_u , even though I am Linux
user "test" (Linux user test should ideally be mapped to user_u).

Is there a way for SELinux to automatically adjust/change the SELinux
user, whenever the Linux user is changed via "su"  ???

Thanks in advance,

- Rezaul.

P.S. I can appreciate why first logging in as Linux user test, and then
su to root, will still keep my SELinux user to user_u.  But just curious
if there is any flexibility in this regard ?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
