Message-ID: <41751792.4060207@redhat.com>
Date: Tue, 19 Oct 2004 09:33:06 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
CC: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Adding alternate root patch to restorecon (setfiles?)
References: <41741A2C.8040408@redhat.com> <20041018205136.GA2536@jmh.mhn.de>
In-Reply-To: <20041018205136.GA2536@jmh.mhn.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thomas Bleher wrote:

>* Daniel J Walsh <dwalsh@redhat.com> [2004-10-18 22:40]:
>  
>
>>We are beginning to look into how we could support clusters with SELinux. 
>>Usually in clusters you move your configuration off on to some shared 
>>storage.
>>
>>So you might do a cp -a  /var/named /shared/var/named
>>
>>We need some way of relabeling these directories with file context.  My 
>>idea is to add an alternate
>>root qualifier to restorecon
>>    
>>
>
>One thing to note here is that restorecon becomes more dangerous with
>your changes. Right now restorecon is relatively safe in that you can
>only change file labels to their system default. It would probably be
>acceptable in most environments to give users access to restorecon so
>they could properly set labels for files in their home dir.
>
>With your changes and this scenario, users could do something like
>        restorecon -p /home/foo /home/foo/sbin/unix_chkpwd
>and start reading /etc/shadow.
>So I am not sure this is the right way.
>
>Thomas
>
>
>  
>
Good point, good thing I never put out a patched version.  We need ideas 
on the best way to do something
like this.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
