Message-ID: <416172B8.1030200@redhat.com>
Date: Mon, 04 Oct 2004 11:56:40 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Patch to restorecon to add -R switch
References: <41584DCA.7030006@redhat.com> <1096904808.32008.53.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1096904808.32008.53.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Mon, 2004-09-27 at 13:28, Daniel J Walsh wrote:
>  
>
>>This will allow us to
>>
>>restorecon -R /dev in the initscripts.
>>
>>Also patch adds some fixed for fixfiles.
>>    
>>
>
>So, how does this differ from just running setfiles on /dev instead?
>
>  
>
Setfiles allows for the specification of random file_context files so we 
do not allow init to run setfiles.
restorecon only reads the system file_context file.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
