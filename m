MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: File_contexts file and semanage...
Date: Mon, 19 May 2008 14:07:23 -0400
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D049AF445@de01exm68.ds.mot.com>
In-Reply-To: <482E1DCD.1000505@manicmethod.com>
References: <4820D9FB.8010802@martinorr.name> <1210248530.6434.145.camel@moss-spartans.epoch.ncsc.mil> <482E1DCD.1000505@manicmethod.com>
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "SELinux List" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi All,

I have some unique directories in my filesystem, that I wanted to label
a certain way. As such, I added a few modifications to the file_contexts
files at the following locations:

/etc/selinux/strict/modules/active/file_contexts
/etc/selinux/strict/modules/active/file_contexts.template
/etc/selinux/strict/contexts/files/file_contexts

When my Linux machine boots up, and I label the entire filesystem,
everything gets labelled correctly.

Later, I have a script that runs the  "semanage login -a -s xxx yyy"
command.
I noticed, right after the 'semanage' command is run, the above three
files get reset back to the original defaults ???

Why does this happen, and any way for these file_contexts files to
remain the way I set them initially ???

Ques 2.  Initially after the system is labelled the way I want,  the
/etc/shadow file is labelled as  shadow_t !
Later, some application task on my system is probably running "useradd"
or "userdel", and as a result, I have two files labelled as follows:

/etc/shadow    etc_runtime_t
/etc/shadow-   shadow_t


It looks like useradd or userdel is creating a backup copy (shadow-),
but I am not interested in that. The shadow file is what I am interested
in, and its label is getting changed to  etc_runtime_t.  Why could this
be happenning, and how do I stop it ?

Thanks in advance for your help,

- Rezaul.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
