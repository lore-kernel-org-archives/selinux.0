Message-ID: <55546DBC.4080100@gmail.com>
Date: Thu, 14 May 2015 15:11:16 +0530
From: rajkumar <rajkumarmadhani@gmail.com>
MIME-Version: 1.0
To: Emre Can Kucukoglu <eckucukoglu@gmail.com>
Subject: Re: How to start SELinux on embedded device
References: <55544356.1050802@gmail.com>
 <CA+2y114X0say5NgXegHhnfD2RgP4zvMWTLdjpoVkqvhAGokFrw@mail.gmail.com>
In-Reply-To: <CA+2y114X0say5NgXegHhnfD2RgP4zvMWTLdjpoVkqvhAGokFrw@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------020408080606060303090308"
Cc: Selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------020408080606060303090308
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

Thank you Emre Can Kucukoglu,
I am just at understanding level.

need your support further.

Regards
Rajkumar



On Thursday 14 May 2015 01:14 PM, Emre Can Kucukoglu wrote:
> Hi Rajkumar,
>
> Basically, you need 3 major steps.
>
> 1. Enable security framework and SELinux configurations from linux kernel.
> like: CONFIG_SECURITY_SELINUX, DEFAULT_SECURITY_SELINUX, 
> SECURITY_SELINUX_AVC_STATS, CONFIG_SECURITY_SELINUX_BOOTPARAM, 
> SECURITY_SELINUX_DEVELOP, CONFIG_SECURITY_SELINUX_DISABLE
> 2. Then download and compile SELinux: 
> https://github.com/SELinuxProject/selinux. Add cross-compiled files to 
> your rootfs.
> 3. Download and configure SELinux reference policy project, however 
> keep in mind, you have lots of redundant policy modules in reference 
> policy, you should keep them out. Load policies, enable your SELinux. 
> (see setenforce, /etc/selinux/config, boot args, kernel configuration).
> 4. Later, you 'can' download and compile setools3 (vs3 is stable one i 
> guess) to ease your policy management.
>
> I think SELinux notebook is a good resource to learn how to use 
> SELinux, not how to port it.
> You can look my presentation about SELinux overview, however keep in 
> mind that it is not reviewed yet.
> https://docs.google.com/presentation/d/1Qtl_vaxvcAPse47d2sCWH6IAhn9XYFKkHEsOddobHpw/edit?usp=sharing
>
> In which step do you think you are?
>
> 2015-05-14 9:40 GMT+03:00 rajkumar <rajkumarmadhani@gmail.com 
> <mailto:rajkumarmadhani@gmail.com>>:
>
>     Hi I am Rajkumar new to SELinux.
>
>
>     My Requirement is to start SELinux porting on Embedded device
>     consists of ARM processor.
>     Using linux kernel version is 3.0.35.
>     I started reading The SELinux notebook 4th edition.
>     Made some changes in .config like enabling SELinux in kernel.
>     And what are the changes need to be done rootfs apart from DAC 
>     and in kernel.
>
>
>     Please provide guidelines.
>
>     -- 
>     Regards
>     Rajkumar.m
>     +91 8501021114 <tel:%2B91%208501021114>
>
>     _______________________________________________
>     Selinux mailing list
>     Selinux@tycho.nsa.gov <mailto:Selinux@tycho.nsa.gov>
>     To unsubscribe, send email to Selinux-leave@tycho.nsa.gov
>     <mailto:Selinux-leave@tycho.nsa.gov>.
>     To get help, send an email containing "help" to
>     Selinux-request@tycho.nsa.gov <mailto:Selinux-request@tycho.nsa.gov>.
>
>
>
>
> -- 
> Emre Can Kucukoglu

-- 
Regards
Rajkumar.m


--------------020408080606060303090308
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Hi <br>
    <br>
    Thank you Emre Can Kucukoglu,<br>
    I am just at understanding level.<br>
     <br>
    need your support further.<br>
    <br>
    Regards<br>
    Rajkumar<br>
    <br>
    <br>
    <br>
    <div class="moz-cite-prefix">On Thursday 14 May 2015 01:14 PM, Emre
      Can Kucukoglu wrote:<br>
    </div>
    <blockquote
cite="mid:CA+2y114X0say5NgXegHhnfD2RgP4zvMWTLdjpoVkqvhAGokFrw@mail.gmail.com"
      type="cite">
      <div dir="ltr">Hi Rajkumar,
        <div><br>
        </div>
        <div>Basically, you need 3 major steps.
          <div><br>
          </div>
          <div>1. Enable security framework and SELinux configurations
            from linux kernel.</div>
          <div>like: CONFIG_SECURITY_SELINUX, DEFAULT_SECURITY_SELINUX,
            SECURITY_SELINUX_AVC_STATS,
            CONFIG_SECURITY_SELINUX_BOOTPARAM, SECURITY_SELINUX_DEVELOP,
            CONFIG_SECURITY_SELINUX_DISABLE<br>
          </div>
          <div>2. Then download and compile SELinux: <a
              moz-do-not-send="true"
              href="https://github.com/SELinuxProject/selinux">https://github.com/SELinuxProject/selinux</a>.
            Add cross-compiled files to your rootfs.</div>
          <div>3. Download and configure SELinux reference policy
            project, however keep in mind, you have lots of redundant
            policy modules in reference policy, you should keep them
            out. Load policies, enable your SELinux. (see setenforce,
            /etc/selinux/config, boot args, kernel configuration).</div>
          <div>4. Later, you 'can' download and compile setools3 (vs3 is
            stable one i guess) to ease your policy management.</div>
          <div><br>
          </div>
          <div>I think SELinux notebook is a good resource to learn how
            to use SELinux, not how to port it. </div>
          <div>You can look my presentation about SELinux overview,
            however keep in mind that it is not reviewed yet.</div>
          <div><a moz-do-not-send="true"
href="https://docs.google.com/presentation/d/1Qtl_vaxvcAPse47d2sCWH6IAhn9XYFKkHEsOddobHpw/edit?usp=sharing">https://docs.google.com/presentation/d/1Qtl_vaxvcAPse47d2sCWH6IAhn9XYFKkHEsOddobHpw/edit?usp=sharing</a><br>
          </div>
          <div><br>
          </div>
          <div>In which step do you think you are?</div>
        </div>
      </div>
      <div class="gmail_extra"><br>
        <div class="gmail_quote">2015-05-14 9:40 GMT+03:00 rajkumar <span
            dir="ltr">&lt;<a moz-do-not-send="true"
              href="mailto:rajkumarmadhani@gmail.com" target="_blank">rajkumarmadhani@gmail.com</a>&gt;</span>:<br>
          <blockquote class="gmail_quote" style="margin:0 0 0
            .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi I am
            Rajkumar new to SELinux.<br>
            <br>
            <br>
            My Requirement is to start SELinux porting on Embedded
            device consists of ARM processor.<br>
            Using linux kernel version is 3.0.35.<br>
            I started reading The SELinux notebook 4th edition.<br>
            Made some changes in .config like enabling SELinux in
            kernel.<br>
            And what are the changes need to be done rootfs apart from
            DAC  and in kernel.<br>
            <br>
            <br>
            Please provide guidelines.<span class="HOEnZb"><font
                color="#888888"><br>
                <br>
                -- <br>
                Regards<br>
                Rajkumar.m<br>
                <a moz-do-not-send="true" href="tel:%2B91%208501021114"
                  value="+918501021114" target="_blank">+91 8501021114</a><br>
                <br>
                _______________________________________________<br>
                Selinux mailing list<br>
                <a moz-do-not-send="true"
                  href="mailto:Selinux@tycho.nsa.gov" target="_blank">Selinux@tycho.nsa.gov</a><br>
                To unsubscribe, send email to <a moz-do-not-send="true"
                  href="mailto:Selinux-leave@tycho.nsa.gov"
                  target="_blank">Selinux-leave@tycho.nsa.gov</a>.<br>
                To get help, send an email containing "help" to <a
                  moz-do-not-send="true"
                  href="mailto:Selinux-request@tycho.nsa.gov"
                  target="_blank">Selinux-request@tycho.nsa.gov</a>.<br>
              </font></span></blockquote>
        </div>
        <br>
        <br clear="all">
        <div><br>
        </div>
        -- <br>
        <div class="gmail_signature">Emre Can Kucukoglu</div>
      </div>
    </blockquote>
    <br>
    <pre class="moz-signature" cols="72">-- 
Regards
Rajkumar.m</pre>
  </body>
</html>

--------------020408080606060303090308--
