From: Laurent Bigonville <bigon@debian.org>
Subject: Re: [PATCH] policycoreutils: Use "new" sepolicy icon in .desktop file
 for sepolicy gui
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <20161102130437.15464-1-bigon@debian.org>
 <1fcd09f4-96fa-7c93-7b3b-7cae8c328733@tycho.nsa.gov>
Message-ID: <a8c6f311-0769-d49c-e2f6-94314b6b1f6b@debian.org>
Date: Thu, 3 Nov 2016 17:16:26 +0100
MIME-Version: 1.0
In-Reply-To: <1fcd09f4-96fa-7c93-7b3b-7cae8c328733@tycho.nsa.gov>
Content-Type: multipart/alternative;
 boundary="------------13FF2CB4D07ECF0E48C0F4BF"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------13FF2CB4D07ECF0E48C0F4BF
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 02/11/16 à 14:27, Stephen Smalley a écrit :
> On 11/02/2016 09:04 AM, Laurent Bigonville wrote:
>> From: Laurent Bigonville<bigon@bigon.be>
>>
>> New hires icons have been added to the repository end 2013 but the
>> sepolicy .desktop file is not using it, let's fix that.
> Thanks, applied.  I plan to move these icon files over to the gui/
> directory in the splitpolicycoreutils branch.
Thanks,

I should probably reply to your initial mail about the split, but 
shouldn't the gui directory completely dropped? I mean 
system-config-selinux is python2 only and need to be ported to GObject 
introspection and GTKBuilder if we want it to work in python3 (or it 
should be ported, but it looked non trivial to my meager knowledge).

--------------13FF2CB4D07ECF0E48C0F4BF
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Le 02/11/16 à 14:27, Stephen Smalley a écrit :<br>
    <blockquote
      cite="mid:1fcd09f4-96fa-7c93-7b3b-7cae8c328733@tycho.nsa.gov"
      type="cite">
      <pre wrap="">On 11/02/2016 09:04 AM, Laurent Bigonville wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">From: Laurent Bigonville <a class="moz-txt-link-rfc2396E" href="mailto:bigon@bigon.be">&lt;bigon@bigon.be&gt;</a>

New hires icons have been added to the repository end 2013 but the
sepolicy .desktop file is not using it, let's fix that.
</pre>
      </blockquote>
      <pre wrap="">Thanks, applied.  I plan to move these icon files over to the gui/
directory in the splitpolicycoreutils branch.
</pre>
    </blockquote>
    Thanks,<br>
    <br>
    I should probably reply to your initial mail about the split, but
    shouldn't the gui directory completely dropped? I mean
    system-config-selinux is python2 only and need to be ported to
    GObject introspection and GTKBuilder if we want it to work in
    python3 (or it should be ported, but it looked non trivial to my
    meager knowledge).<br>
  </body>
</html>

--------------13FF2CB4D07ECF0E48C0F4BF--
