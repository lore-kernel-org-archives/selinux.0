Message-ID: <4471BA2C.7090806@us.ibm.com>
Date: Mon, 22 May 2006 09:18:36 -0400
From: Janak Desai <janak@us.ibm.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: tmraz@redhat.com, sds@tycho.nsa.gov, valdis.kletnieks@vt.edu,
        serue@us.ibm.com, klaus@atsec.com, selinux@tycho.nsa.gov
Subject: Re: pam_namespace improvements ..
References: <44710A40.4060309@us.ibm.com> <200605221105.55104.russell@coker.com.au>
In-Reply-To: <200605221105.55104.russell@coker.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>On Monday 22 May 2006 10:48, Janak Desai <janak@us.ibm.com> wrote:
>  
>
>>After going thorugh the pam_namespace thread again and after talking to
>>some of my peeps, I do see that a mode 000 instance parent can thwart
>>attacks by non-root daemons and non-polyinstanted users on polyinstanted
>>users.
>>    
>>
>
>OK.
>
>  
>
>>The current implementation of pam_namespace already depends on the
>>existance of the instance parent and allows the admin to configure the
>>names of different instances. I will update the namespace.conf man page,
>>and the comment text in the namespace.conf file to guide admins to
>>appropriately create a different instance parent (and not use the poly
>>dir itself, like the current example suggests). That way, an admin can
>>create an intermediate directory like .inst with 000 or create a whole
>>different directory with 000.
>>    
>>
>
>I'm glad that we have agreement on this issue.  However I would like to go 
>further.
>
>I would like to have the default configuration of major distributions (Fedora, 
>Debian, and Gentoo) have some changes to make things more secure in this 
>regard.
>
>I believe that we need a script run at boot time to create such directories if 
>they don't exist and rename a directory with the name but the wrong 
>permissions before creating it if necessary.  Having the administrator create 
>the directory with mkdir and then chmod it will work for Fedora IFF a 
>persistent file system is used for /tmp.  Due to other issues SE Linux 
>compels the use of a persistent file system for /tmp at this time (I consider 
>this a bug and have long-term plans to fix it), however we also want to 
>support non-SE users.
>
>I also believe that pam_namespace should have the optional ability (determined 
>by a command-line parameter or a config-file setting) to verify the Unix 
>permissions and SE Linux context of the mode 000 directory and reject user 
>logins if the permissions are considered to be inappropriate.
>
>Configuration tools to support enabling all this functionality in a convenient 
>manner would also be good.
>
>  
>
Ok, thanks. I will add an option to pam_namespace to allow an admin to 
NOT check
the mode of the instance parent. By default, pam_namespace will require 
the mode
to be 000. As far as SELinux context, what is the appropriate context 
for an instance
parent? Isn't it ok to leave that upto the system security policy? 
Because of different
types of polyinstantiated directories, I cannot comprehend a definitive 
context
that pam_namespace could/should check for.

Thanks.

-Janak

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
