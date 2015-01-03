Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t03CkRtp031980
 for <selinux@tycho.nsa.gov>; Sat, 3 Jan 2015 07:46:27 -0500
Message-ID: <54A7E49C.6030805@redhat.com>
Date: Sat, 03 Jan 2015 07:46:20 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="=_Boundary-2940-1420289234-0001-2"
To: Bhuvan Gupta <bhuvangu@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: Problem running "selinux sandbox" with java
References: <CAF4ab9Wu1hf5qBKj5L7mtpp4eqqfRixJY3dvZJ+n3+xPQNxnzw@mail.gmail.com>
In-Reply-To: <CAF4ab9Wu1hf5qBKj5L7mtpp4eqqfRixJY3dvZJ+n3+xPQNxnzw@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Boundary-2940-1420289234-0001-2
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

Take a look at the AVC's.  I think you are probably getting denied
execmem/execstack or something like that.

Does it work in permissive mode?

On 12/28/2014 09:04 AM, Bhuvan Gupta wrote:
> Hello all, 
> Greeting and happy new year to all.
> I am trying to sandbox a java application using selinux sandbox.
> System details: Redhat 6 | x86_64 | no x server install | jdk7 from
> oracle tar.gz version | cgred and cgconfig are stop 
> The cmd (run as root)
> /         sandbox /root/jdk/bin/java -version/
> above cmd failed with 
> /         /root/jdk/bin/java: error while loading shared libraries:
> libjli.so: cannot open shared object file: No such file or directory/
>
> Digging, revealed that "libjli.so" is RPATH shared library. so i
> thought ok since sandbox is copying my bin/java to /tmp/sandbox_random
> therefore a hardcode path will not be found.
> Then i change the RPATH using "chrpath" utility and changed it to a
> hardcode value
> But still it showed the same error.
>
> Then i used the -M -i option of sandbox and ran following command (i
> included all the .so file it complaint about):
> /      sandbox -M -i /root/jdk/lib/amd64/jli/libjli.so -i
> /root/jdk/jre/lib/amd64/libjava.so -i /root/jdk/jre/lib/amd64/jvm.cfg
> -i /root/jdk/jre/lib/amd64/server/libjvm.so -i  
>  /root/jdk/jre/lib/amd64/libverify.so -i
> /root/jdk/jre/lib/amd64/libzip.so /root/jdk/bin/java  -version
> /
>
> Following command resulted in this error:
> /Java HotSpot(TM) 64-Bit Server VM warning: INFO:
> os::commit_memory(0x00007fb039000000, 2555904, 1) failed;
> error='Permission denied' (errno=13)/
> /#/
> /# There is insufficient memory for the Java Runtime Environment to
> continue./
> /# Native memory allocation (malloc) failed to allocate 2555904 bytes
> for committing reserved memory./
> /# An error report file with more information is saved as:/
> /# /root/hs_err_pid1270.log/
>
> Now i used the strace to see what happened and strace printed(small
> section) 
> /clone(child_stack=0,
> flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
> child_tidptr=0x7fb15b6359d0) = 8268/
> /close(4)                                = 0/
> /read(3, "", 1048576)                    = 0/
> /close(3)                                = 0/
> /wait4(8268, Java HotSpot(TM) 64-Bit Server VM warning: INFO:
> os::commit_memory(0x00007f4579000000, 2555904, 1) failed;
> error='Permission denied' (errno=13)/
>
> I have enough space for sure
>
> */Can you guys please indicate what might be wrong ?/*
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.


--=_Boundary-2940-1420289234-0001-2
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
X-Mime-Autoconverted: from 8bit to quoted-printable by mime827

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    Take a look at the AVC's.=A0 I think you are probably getting denied
    execmem/execstack or something like that.<br>
    <br>
    Does it work in permissive mode?<br>
    <br>
    <div class=3D"moz-cite-prefix">On 12/28/2014 09:04 AM, Bhuvan Gupta
      wrote:<br>
    </div>
    <blockquote
cite=3D"mid:CAF4ab9Wu1hf5qBKj5L7mtpp4eqqfRixJY3dvZJ+n3+xPQNxnzw@mail.gma=
il.com"
      type=3D"cite">
      <div dir=3D"ltr"><span style=3D"font-size:13px">Hello all,=A0</spa=
n>
        <div style=3D"font-size:13px">Greeting and happy new year to all=
.</div>
        <div style=3D"font-size:13px">I am trying to sandbox a java
          application using selinux sandbox.</div>
        <div style=3D"font-size:13px">System details: Redhat 6 | x86_64 =
|
          no x server install | jdk7 from oracle tar.gz version | cgred
          and=A0cgconfig are stop=A0</div>
        <div style=3D"font-size:13px">The cmd (run as root)</div>
        <div style=3D"font-size:13px"><i>=A0 =A0 =A0 =A0=A0=A0sandbox
            /root/jdk/bin/java -version</i></div>
        <div style=3D"font-size:13px">above cmd failed with=A0</div>
        <div style=3D"font-size:13px"><i>=A0 =A0 =A0 =A0 =A0/root/jdk/bi=
n/java:
            error while loading shared libraries: libjli.so: cannot open
            shared object file: No such file or directory</i><br>
        </div>
        <div style=3D"font-size:13px"><br>
        </div>
        <div style=3D"font-size:13px">Digging, revealed that "libjli.so"
          is RPATH shared library. so i thought ok since sandbox is
          copying my bin/java to /tmp/sandbox_random therefore a
          hardcode path will not be found.</div>
        <div style=3D"font-size:13px">Then i change the RPATH using
          "chrpath" utility and changed it to a hardcode value</div>
        <div style=3D"font-size:13px">But still it showed the same error=
.</div>
        <div style=3D"font-size:13px"><br>
        </div>
        <div style=3D"font-size:13px">Then i used the -M -i option of
          sandbox and ran following command (i included all the .so file
          it complaint about):</div>
        <div style=3D"font-size:13px"><i>=A0 =A0 =A0 sandbox -M -i
            /root/jdk/lib/amd64/jli/libjli.so -i
            /root/jdk/jre/lib/amd64/libjava.so -i
            /root/jdk/jre/lib/amd64/jvm.cfg -i
            /root/jdk/jre/lib/amd64/server/libjvm.so -i =A0
            =A0/root/jdk/jre/lib/amd64/libverify.so -i
            /root/jdk/jre/lib/amd64/libzip.so /root/jdk/bin/java
            =A0-version<br>
          </i></div>
        <div style=3D"font-size:13px"><br>
        </div>
        <div style=3D"font-size:13px">Following command resulted in this
          error:</div>
        <div style=3D"font-size:13px">
          <div><i>Java HotSpot(TM) 64-Bit Server VM warning: INFO:
              os::commit_memory(0x00007fb039000000, 2555904, 1) failed;
              error=3D'Permission denied' (errno=3D13)</i></div>
          <div><i>#</i></div>
          <div><i># There is insufficient memory for the Java Runtime
              Environment to continue.</i></div>
          <div><i># Native memory allocation (malloc) failed to allocate
              2555904 bytes for committing reserved memory.</i></div>
          <div><i># An error report file with more information is saved
              as:</i></div>
          <div><i># /root/hs_err_pid1270.log</i></div>
        </div>
        <div style=3D"font-size:13px"><br>
        </div>
        <div style=3D"font-size:13px">Now i used the strace to see what
          happened and strace printed(small section)=A0</div>
        <div style=3D"font-size:13px">
          <div><i>clone(child_stack=3D0,
              flags=3DCLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
              child_tidptr=3D0x7fb15b6359d0) =3D 8268</i></div>
          <div><i>close(4) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0=3D 0</i></div>
          <div><i>read(3, "", 1048576) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0=3D 0</i></div>
          <div><i>close(3) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0=3D 0</i></div>
          <div><i>wait4(8268, Java HotSpot(TM) 64-Bit Server VM warning:
              INFO: os::commit_memory(0x00007f4579000000, 2555904, 1)
              failed; error=3D'Permission denied' (errno=3D13)</i></div>
        </div>
        <div style=3D"font-size:13px"><br>
        </div>
        <div style=3D"font-size:13px">I have enough space for sure</div>
        <div style=3D"font-size:13px"><br>
        </div>
        <div style=3D"font-size:13px"><b><i>Can you guys please indicate
              what might be wrong ?</i></b></div>
      </div>
      <br>
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap=3D"">_______________________________________________
Selinux mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:Selinux@tycho.nsa.g=
ov">Selinux@tycho.nsa.gov</a>
To unsubscribe, send email to <a class=3D"moz-txt-link-abbreviated" href=
=3D"mailto:Selinux-leave@tycho.nsa.gov">Selinux-leave@tycho.nsa.gov</a>.
To get help, send an email containing "help" to <a class=3D"moz-txt-link=
-abbreviated" href=3D"mailto:Selinux-request@tycho.nsa.gov">Selinux-requ=
est@tycho.nsa.gov</a>.</pre>
    </blockquote>
    <br>
  </body>
</html>

--=_Boundary-2940-1420289234-0001-2--
