Message-ID: <4A724FA0.9010001@ii.net>
Date: Fri, 31 Jul 2009 09:57:52 +0800
From: Cliffe <cliffe@ii.net>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        slide@tresys.com, Christopher Pardy <cpardy@redhat.com>
Subject: Re: Help with SELinux policy for Usability Study
References: <200907300352.n6U3qvAC012682@tarius.tycho.ncsc.mil>	 <4A711890.2030101@ii.net>	 <1248955358.11627.91.camel@moss-pluto.epoch.ncsc.mil>	 <4A71AD1A.5030406@ii.net> <1248965089.11627.137.camel@moss-pluto.epoch.ncsc.mil> <4A71D8CE.1010700@redhat.com>
In-Reply-To: <4A71D8CE.1010700@redhat.com>
Content-Type: multipart/alternative;
 boundary="------------080803060207040905080208"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080803060207040905080208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Daniel J Walsh wrote:
> BTW, if you use the sepolgen command line that is in F11 and Rawhide, it has new features to examine the executable and rpm information to generate more data automatigically.  It is using the same framework that polgengui is using. 
>
> You can execute
>
> sepolgen /usr/sbin/myapp
>
> And it will generate the myapp,te, if, fc, sh file automatically, No gui to walk though.
>
> For example it will look for paths in the rpm that match /var/run/myapp, /var/lib/myapp ... and create proper types.
> It also runs nm -D /usr/sbin/myapp looking for function calls that it knows require certain interfaces,  If it find syslog it will add the 
>
> logging_send_syslog_msg(myapp_t) 
>
> call.
>
> I have not merged this stuff back into the GUI yet.
>   

Thanks. They sound like helpful features. They sound similar to some of 
the techniques my own tool uses.

I tested sepolgen with a few apps. Since the results still require a 
very similar amount of manual editing it is probably fairest to use the 
gui tool as much as possible as the other systems participants will use 
all use gui policy management tools.

Some information about the study:
    - Participants will be shown a prerecorded explanation and 
demonstration of SELinux
    - And have a limited amount of time to confine some programs
    - I don't want to go into too much detail here until the study is 
complete

Justification for using polgengui:
    - It ships standard with fedora
    - It has a gui (like the other tools they will be using)
    - It has a short learning curve (as opposed to perhaps SLIDE, which 
appears to be a more comprehensive tool for policy design but maybe not 
as suited to the average user)

Some questions:
Does SLIDE automate more of the process, such as adding to the created 
policy?
Is there a tool or command to put a domain into enforcing mode rather 
than manually editing the .te file? (system-config-selinux seems to 
think it is already in enforcing mode)

Some suggestions:
It might be a good idea to make the gui tools such as setroubleshoot 
aware of permissive domains, as it simply says that selinux enforcing 
mode is on.
It may be a good idea to create a gui tool which steps users through the 
process of adding to a .te file using audit2allow (if one doesn't exist 
already).

Christopher Pardy wrote:
> Please CC me any results you find as well as any issues with the gui tools as I'm revamping them for F12.
>   
Sure. Participants will give feedback such as suggestions for improvement.

Thanks again everyone for your advice and suggestions,

Cliffe.

--------------080803060207040905080208
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Daniel J Walsh wrote:
<blockquote cite="mid:4A71D8CE.1010700@redhat.com" type="cite">
  <pre wrap=""><!---->BTW, if you use the sepolgen command line that is in F11 and Rawhide, it has new features to examine the executable and rpm information to generate more data automatigically.  It is using the same framework that polgengui is using. 

You can execute

sepolgen /usr/sbin/myapp

And it will generate the myapp,te, if, fc, sh file automatically, No gui to walk though.

For example it will look for paths in the rpm that match /var/run/myapp, /var/lib/myapp ... and create proper types.
It also runs nm -D /usr/sbin/myapp looking for function calls that it knows require certain interfaces,  If it find syslog it will add the 

logging_send_syslog_msg(myapp_t) 

call.

I have not merged this stuff back into the GUI yet.
  </pre>
</blockquote>
<br>
Thanks. They sound like helpful features. They sound similar to some of
the techniques my own tool uses.<br>
<br>
I tested sepolgen with a few apps. Since the results still require a
very similar amount of manual editing it is probably fairest to use the
gui tool as much as possible as the other systems participants will use
all use gui policy management tools. <br>
<br>
Some information about the study:<br>
&nbsp;&nbsp;&nbsp; - Participants will be shown a prerecorded explanation and
demonstration of SELinux<br>
&nbsp;&nbsp;&nbsp; - And have a limited amount of time to confine some programs<br>
&nbsp;&nbsp;&nbsp; - I don't want to go into too much detail here until the study is
complete<br>
<br>
Justification for using polgengui:<br>
&nbsp;&nbsp;&nbsp; - It ships standard with fedora<br>
&nbsp;&nbsp;&nbsp; - It has a gui (like the other tools they will be using)<br>
&nbsp;&nbsp;&nbsp; - It has a short learning curve (as opposed to perhaps SLIDE, which
appears to be a more comprehensive tool for policy design but maybe not
as suited to the average user)<br>
<br>
Some questions:<br>
Does SLIDE automate more of the process, such as adding to the created
policy?<br>
Is there a tool or command to put a domain into enforcing mode rather
than manually editing the .te file? (system-config-selinux seems to
think it is already in enforcing mode)<br>
<br>
Some suggestions:<br>
It might be a good idea to make the gui tools such as setroubleshoot
aware of permissive domains, as it simply says that selinux enforcing
mode is on.<br>
It may be a good idea to create a gui tool which steps users through
the process of adding to a .te file using audit2allow (if one doesn't
exist already).<br>
<br>
Christopher Pardy wrote:
<blockquote cite="mid:4A7209A5.80205@redhat.com" type="cite">
  <pre wrap="">Please CC me any results you find as well as any issues with the gui tools as I'm revamping them for F12.
  </pre>
</blockquote>
Sure. Participants will give feedback such as suggestions for
improvement.<br>
<br>
Thanks again everyone for your advice and suggestions,<br>
<br>
Cliffe.<br>
</body>
</html>

--------------080803060207040905080208--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
