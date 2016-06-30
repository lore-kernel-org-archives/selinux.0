Subject: Fwd: SElinux user tools 2.5 change
References: <35737536-B901-44F9-8336-509CDA386932@wal-mart.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, James Carter <jwcart2@tycho.nsa.gov>,
 Miroslav Grepl <mgrepl@redhat.com>, Lukas Vrabec <lvrabec@redhat.com>,
 SELinux <selinux@tycho.nsa.gov>
From: Daniel J Walsh <dwalsh@redhat.com>
Message-ID: <909baadb-ae53-d6c7-be85-c9d645def448@redhat.com>
Date: Thu, 30 Jun 2016 14:47:55 -0700
MIME-Version: 1.0
In-Reply-To: <35737536-B901-44F9-8336-509CDA386932@wal-mart.com>
Content-Type: multipart/alternative;
 boundary="------------D3563183CE03FD10B21CEE76"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------D3563183CE03FD10B21CEE76
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

  A customer is asking:

The SELinux userspace tools version 2.5 introduced a change to remove 
the semodule version from the semodule –l output.  This poses problems 
for people (like us) who are using configuration management tools like 
Puppet to manage SELinux modules – how is Puppet supposed to know which 
version of the module is installed?  Should it try to load the module 
every time?

I have raised the issue with Puppet as 
https://tickets.puppetlabs.com/browse/PUP-5649 but I believe the real 
question should be, how is a config management system supposed to know 
which version of a module to try to install?

Thanks for any assistance you can provide with this, and we will 
continue to run in enforcing mode by default for RHEL 7+.



--------------D3563183CE03FD10B21CEE76
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=utf-8">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-forward-container"><span style="font-size:11.0pt"><o:p></o:p></span>
      <div class="WordSection1">
        <p class="MsoNormal"><span style="font-size:11.0pt"><o:p> A
              customer is asking:</o:p></span></p>
        <p class="MsoNormal"><span style="font-size:11.0pt">The SELinux
            userspace tools version 2.5 introduced a change to remove
            the semodule version from the semodule –l output.  This
            poses problems for people (like us) who are using
            configuration management tools like Puppet to manage SELinux
            modules – how is Puppet supposed to know which version of
            the module is installed?  Should it try to load the module
            every time?<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-size:11.0pt"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span style="font-size:11.0pt">I have
            raised the issue with Puppet as
            <a moz-do-not-send="true"
              href="https://tickets.puppetlabs.com/browse/PUP-5649">https://tickets.puppetlabs.com/browse/PUP-5649</a>
            but I believe the real question should be, how is a config
            management system supposed to know which version of a module
            to try to install?<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-size:11.0pt"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span style="font-size:11.0pt">Thanks for
            any assistance you can provide with this, and we will
            continue to run in enforcing mode by default for RHEL 7+.<o:p></o:p></span></p>
        <br>
      </div>
    </div>
  </body>
</html>

--------------D3563183CE03FD10B21CEE76--
