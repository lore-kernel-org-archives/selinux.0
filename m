Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4O3F816009326
 for <selinux@tycho.nsa.gov>; Fri, 23 May 2014 23:15:08 -0400
Received: by mail-pb0-f48.google.com with SMTP id rr13so4945030pbb.7
 for <selinux@tycho.nsa.gov>; Fri, 23 May 2014 20:15:09 -0700 (PDT)
Received: from [192.168.1.2] ([117.201.88.118])
 by mx.google.com with ESMTPSA id xw5sm22340900pab.30.2014.05.23.20.15.07
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Fri, 23 May 2014 20:15:08 -0700 (PDT)
Message-ID: <53800E1E.1090709@gmail.com>
Date: Sat, 24 May 2014 08:42:30 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: SAMBA WITH SELINUX
References: <CANh19KB4h_y9QP9LApEiKLmfhFxa9LOwi58_e_XmWBWQT0vDLQ@mail.gmail.com>
 <53800D97.2090103@gmail.com>
In-Reply-To: <53800D97.2090103@gmail.com>
Content-Type: multipart/alternative;
 boundary="------------050504010806030706010309"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------050504010806030706010309
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/24/14 08:40, dE wrote:
> On 05/24/14 01:02, toản cù wrote:
>> Hi all!
>>
>>     I just researching policy in selinux and Samba , SELinux has 
>> policy module separate for samba. I only know the label samba_share_t 
>> used to share data when labeled in SELinux enforcing mode.
>>
>>     I want to use SELinux further intervention on the issue 
>> of decentralization for each user to access data on the samba. How 
>> the same file (*. docx, *. txt), user1 can read, write but  user2 is 
>> not.
>>
>>     And one more question: in a group have different users the same 
>> access to the samba. those users have some same rights, and some the 
>> right different. example the rights  to read,write on a file is 
>> different. How to make a difference the rights between users in the 
>> same group
>>
>>  Look forward your help!
>>
>> Thanks!
>>
>>
>> -- 
>> Mr.Toan-Cu Xuan
>>
>> School of Electronics and Telecommunications
>>
>> Hanoi University of Science and Technology
>>
>> 1 Dai Co Viet, Ha noi, Viet nam.
>>
>> Phone: 01656228762
>>
>> Email:xuantoanbkfet@gmail.com <mailto:Email%3Axuantoanbkfet@gmail.com>
>>
>>
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email toSelinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" toSelinux-request@tycho.nsa.gov.
>
> I don't think smbd spawns a new process when a new user logs in 
> (that's why we have 'force user'), so there's no way for SELinux to 
> identify the login user of the SMB service.
>
> Otherwise what could've been done is set the umask to 077 and inherit 
> owner, inherit permissions to yes. So DAC whould've been good enough 
> for the purpose.
>
> I dont remember how

Actually it does.

Set 'username map' and you get what you want with DAC.

--------------050504010806030706010309
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 05/24/14 08:40, dE wrote:<br>
    </div>
    <blockquote cite="mid:53800D97.2090103@gmail.com" type="cite">
      <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
      <div class="moz-cite-prefix">On 05/24/14 01:02, toản cù wrote:<br>
      </div>
      <blockquote
cite="mid:CANh19KB4h_y9QP9LApEiKLmfhFxa9LOwi58_e_XmWBWQT0vDLQ@mail.gmail.com"
        type="cite">
        <div dir="ltr">
          <div><font face="arial, sans-serif">Hi all! </font></div>
          <div><font face="arial, sans-serif"><br>
            </font></div>
          <div><font face="arial, sans-serif">    I just researching
              policy in selinux and Samba , SELinux has policy module
              separate for samba. I only know the label samba_share_t
              used to share data when labeled in SELinux enforcing mode.</font></div>
          <div><font face="arial, sans-serif"><br>
            </font></div>
          <div><font face="arial, sans-serif">    I want to use SELinux
              further intervention on the issue of decentralization for
              each user to access data on the samba. How the same file
              (*. docx, *. txt), user1 can read, write but  user2 is
              not. </font></div>
          <div><font face="arial, sans-serif"><br>
            </font></div>
          <div><font face="arial, sans-serif">    And one more question:
              in a group have different users the same access to the
              samba. those users have some same rights, and some the
              right different. example the rights  to read,write on a
              file is different. How to make a difference the rights
              between users in the same group</font></div>
          <div><font face="arial, sans-serif"><br>
            </font></div>
          <div><font face="arial, sans-serif"> Look forward your help!</font></div>
          <div><font face="arial, sans-serif"><br>
            </font></div>
          <div><font face="arial, sans-serif">Thanks!</font></div>
          <div><br>
          </div>
          <div style="font-family:arial,sans-serif;font-size:13px"> </div>
          <div><br>
          </div>
          -- <br>
          Mr.Toan-Cu Xuan
          <div>
            <p
style="font-family:arial,sans-serif;font-size:13px;background-color:rgb(255,255,255)">School

              of Electronics and Telecommunications</p>
            <p
style="font-family:arial,sans-serif;font-size:13px;background-color:rgb(255,255,255)">Hanoi

              University of Science and Technology</p>
            <p
style="font-family:arial,sans-serif;font-size:13px;background-color:rgb(255,255,255)">1
              Dai Co Viet, Ha noi, Viet nam.</p>
            <p
style="font-family:arial,sans-serif;font-size:13px;background-color:rgb(255,255,255)">Phone:

              01656228762</p>
            <p
style="font-family:arial,sans-serif;font-size:13px;background-color:rgb(255,255,255)"><a
                moz-do-not-send="true"
                href="mailto:Email%3Axuantoanbkfet@gmail.com"
                target="_blank">Email:xuantoanbkfet@gmail.com</a></p>
          </div>
        </div>
        <br>
        <fieldset class="mimeAttachmentHeader"></fieldset>
        <br>
        <pre wrap="">_______________________________________________
Selinux mailing list
<a moz-do-not-send="true" class="moz-txt-link-abbreviated" href="mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a>
To unsubscribe, send email to <a moz-do-not-send="true" class="moz-txt-link-abbreviated" href="mailto:Selinux-leave@tycho.nsa.gov">Selinux-leave@tycho.nsa.gov</a>.
To get help, send an email containing "help" to <a moz-do-not-send="true" class="moz-txt-link-abbreviated" href="mailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.</pre>
      </blockquote>
      <br>
      I don't think smbd spawns a new process when a new user logs in
      (that's why we have 'force user'), so there's no way for SELinux
      to identify the login user of the SMB service.<br>
      <br>
      Otherwise what could've been done is set the umask to 077 and
      inherit owner, inherit permissions to yes. So DAC whould've been
      good enough for the purpose.<br>
      <br>
      I dont remember how <br>
    </blockquote>
    <br>
    Actually it does.<br>
    <br>
    Set 'username map' and you get what you want with DAC.
    <meta http-equiv="CONTENT-TYPE" content="text/html; charset=UTF-8">
    <title></title>
    <meta name="GENERATOR" content="LibreOffice 4.1.4.2 (Linux)">
    <style type="text/css">
	<!--
		@page { margin: 0.79in }
		P { margin-bottom: 0.12in }
		P.western { font-family: "Calibri", sans-serif; font-size: 14pt }
	-->
	</style>
  </body>
</html>

--------------050504010806030706010309--
