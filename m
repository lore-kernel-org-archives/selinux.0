Message-ID: <423AFCAF.5050802@redhat.com>
Date: Fri, 18 Mar 2005 11:07:11 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Jun OKAJIMA <okajima@digitalinfra.co.jp>, SELinux@tycho.nsa.gov
Subject: Re: Do you trust X server?
References: <200503172228.AA00008@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <1111149494.17131.13.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1111149494.17131.13.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Fri, 2005-03-18 at 07:28 +0900, Jun OKAJIMA wrote:
>  
>
>>Hello.
>>
>>I am not sure that here is the proper place to discuss this issue,
>>but do you trust X server (or video driver), when you use your PC
>>with X window?.
>>
>>Most ( and probably all) X server runs as root on Linux.
>>Then, if it has ( and it must have ) a buffer overflow or any vulnerability,
>>and it would execute some cruel code if a certain drawing commands set comes.
>>A cracker makes web sites contain htmls or SVG or ... to make a such commands
>>set to be displayed. Then, you can be cracked with just browsing the pages,
>>not being required to click untrusted contents explicitly.
>>
>>Have you considered this risk? Is there any site about this issue?
>>And any measure to solve this issue with SE linux?
>>    
>>
>
>There are ways to run X with less privilege (unrelated to SELinux), and
>SELinux can then be used to limit the capabilities granted to the X
>server.  X is also a concern for SELinux because without modification,
>it allows uncontrolled information flow among X clients, potentially
>violating the security policy.  The latter concern (but not the former
>one) is being addressed by the security enhanced X work, originally by
>Eamon Walsh and now picked up by Trusted Computer Solutions.  See:
>http://www.nsa.gov/selinux/papers/x11-abs.cfm
>http://www.nsa.gov/selinux/list-archive/0405/7030.cfm
>http://lists.freedesktop.org/pipermail/xorg/2005-February/006452.html
>http://lists.freedesktop.org/archives/xorg/2005-March/006906.html
>
>  
>
Jim Getty's also mentioned at the SELinux Symposium some effort to get X 
to not
need to run as Root (Or at least most of X).



-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
