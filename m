Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s52A0XKf006034
 for <selinux@tycho.nsa.gov>; Mon, 2 Jun 2014 06:00:33 -0400
Received: by mail-pa0-f43.google.com with SMTP id kp14so1778874pab.16
 for <selinux@tycho.nsa.gov>; Mon, 02 Jun 2014 03:00:35 -0700 (PDT)
Received: from [192.168.1.2] ([117.208.71.237])
 by mx.google.com with ESMTPSA id xy2sm61770900pab.16.2014.06.02.03.00.32
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Mon, 02 Jun 2014 03:00:33 -0700 (PDT)
Message-ID: <538C4AA1.3030106@gmail.com>
Date: Mon, 02 Jun 2014 15:27:53 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: How does matchpathcon/setfiles work?
References: <538B4487.8050807@gmail.com>
 <CAPzO=NycsK+-5EDgtJh8nFx7WjFT0isYyxgrKxqqtrq3SdRgkg@mail.gmail.com>
In-Reply-To: <CAPzO=NycsK+-5EDgtJh8nFx7WjFT0isYyxgrKxqqtrq3SdRgkg@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------030201060900070003090509"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------030201060900070003090509
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/02/14 12:12, Sven Vermeulen wrote:
>
> Policies do contain paths. They contain path expressions to be more 
> precise.
>
> During policy load, the path expressions together with the target 
> contexts are extracted and placed in 
> /etc/selinux/mcs/contexts/files/file_contexts, which is where tools 
> like matchpathcon get their information from.
>
> Wkr,
>   Sven Vermeulen
>
> On Jun 1, 2014 5:48 PM, "dE" <de.techno@gmail.com 
> <mailto:de.techno@gmail.com>> wrote:
>
>     As we know, policies don't contain paths. So the working of
>     matchpathcon/setfiles must be based on common sense.
>
>     It looks like it knows certain special folders and it's
>     appropriate security context, for e.g. home folder contents should
>     have files with user_home_t and suggests the correct SELinux user
>     for the files/directories based on which user's home folder is it.
>
>     Other directories/files should have the same security context as
>     the parent directory, like with /opt.
>
>     Is this correct?
>

Do the paths have any other purpose other than defining the default 
security context?

--------------030201060900070003090509
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 06/02/14 12:12, Sven Vermeulen
      wrote:<br>
    </div>
    <blockquote
cite="mid:CAPzO=NycsK+-5EDgtJh8nFx7WjFT0isYyxgrKxqqtrq3SdRgkg@mail.gmail.com"
      type="cite">
      <p dir="ltr">Policies do contain paths. They contain path
        expressions to be more precise.</p>
      <p dir="ltr">During policy load, the path expressions together
        with the target contexts are extracted and placed in
        /etc/selinux/mcs/contexts/files/file_contexts, which is where
        tools like matchpathcon get their information from.</p>
      <p dir="ltr">Wkr, <br>
          Sven Vermeulen</p>
      <div class="gmail_quote">On Jun 1, 2014 5:48 PM, "dE" &lt;<a
          moz-do-not-send="true" href="mailto:de.techno@gmail.com">de.techno@gmail.com</a>&gt;
        wrote:<br type="attribution">
        <blockquote class="gmail_quote" style="margin:0 0 0
          .8ex;border-left:1px #ccc solid;padding-left:1ex">
          As we know, policies don't contain paths. So the working of
          matchpathcon/setfiles must be based on common sense.<br>
          <br>
          It looks like it knows certain special folders and it's
          appropriate security context, for e.g. home folder contents
          should have files with user_home_t and suggests the correct
          SELinux user for the files/directories based on which user's
          home folder is it.<br>
          <br>
          Other directories/files should have the same security context
          as the parent directory, like with /opt.<br>
          <br>
          Is this correct?<br>
        </blockquote>
      </div>
    </blockquote>
    <br>
    Do the paths have any other purpose other than defining the default
    security context?<br>
  </body>
</html>

--------------030201060900070003090509--
