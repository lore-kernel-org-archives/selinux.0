Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3UCuaMW021758
 for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2014 08:56:37 -0400
Message-ID: <5360F2FF.7030709@redhat.com>
Date: Wed, 30 Apr 2014 08:56:31 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <stephen.smalley@gmail.com>,
 selinux <selinux@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 Paul Moore <paul@paul-moore.com>
Subject: Re: [RFC][PATCH] selinux: Report result in avc messages
References: <CAB9W1A3BxZ=U=+t4o3q+EomuxK256Ou1EAqyHXrLm59PB=p7kA@mail.gmail.com>
In-Reply-To: <CAB9W1A3BxZ=U=+t4o3q+EomuxK256Ou1EAqyHXrLm59PB=p7kA@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------050606040700060108070302"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------050606040700060108070302
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I have no problem with this.

On 04/29/2014 07:54 PM, Stephen Smalley wrote:
> Requested for Android in order to distinguish denials that are not in
> fact breaking anything yet due to permissive domains versus denials
> that are being enforced, but seems generally useful.  result field was
> already in the selinux audit data structure and was being passed to
> avc_audit() but wasn't being used.  Seems to cause no harm to ausearch
> or audit2allow to add it as a field.  Comments?
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.


--------------050606040700060108070302
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    I have no problem with this.<br>
    <br>
    <div class="moz-cite-prefix">On 04/29/2014 07:54 PM, Stephen Smalley
      wrote:<br>
    </div>
    <blockquote
cite="mid:CAB9W1A3BxZ=U=+t4o3q+EomuxK256Ou1EAqyHXrLm59PB=p7kA@mail.gmail.com"
      type="cite">
      <pre wrap="">Requested for Android in order to distinguish denials that are not in
fact breaking anything yet due to permissive domains versus denials
that are being enforced, but seems generally useful.  result field was
already in the selinux audit data structure and was being passed to
avc_audit() but wasn't being used.  Seems to cause no harm to ausearch
or audit2allow to add it as a field.  Comments?
</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
Selinux mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a>
To unsubscribe, send email to <a class="moz-txt-link-abbreviated" href="mailto:Selinux-leave@tycho.nsa.gov">Selinux-leave@tycho.nsa.gov</a>.
To get help, send an email containing "help" to <a class="moz-txt-link-abbreviated" href="mailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------050606040700060108070302--
