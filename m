Message-ID: <53D2A36E.8090900@redhat.com>
Date: Fri, 25 Jul 2014 14:35:26 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SELinux-NSA <SELinux@tycho.nsa.gov>,
 Joshua Brindle <brindle@quarksecurity.com>,
 Steve Lawrence <slawrence@tresys.com>
Subject: Re: [RFC] [PATCH] libsemanage: Skip policy module re-link when only
 setting booleans.
References: <53D28DBB.8000905@tycho.nsa.gov>
In-Reply-To: <53D28DBB.8000905@tycho.nsa.gov>
Content-Type: multipart/alternative;
 boundary="------------030002070405000009010308"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------030002070405000009010308
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Nice.
On 07/25/2014 01:02 PM, Stephen Smalley wrote:
> Motivated by:
> https://bugzilla.redhat.com/show_bug.cgi?id=1098446
>
> I believe this is always safe for booleans because we only set their
> value; we are never adding new ones via semanage, unlike for example
> users, ports, nodes, and interfaces.  For the rest, I was wondering why
> we don't save the linked file and just reuse it on those changes rather
> than re-linking each time - that seems like it would be straightforward
> to do in libsemanage and make those operations significantly faster and
> less memory intensive.
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.


--------------030002070405000009010308
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Nice.<br>
    <div class="moz-cite-prefix">On 07/25/2014 01:02 PM, Stephen Smalley
      wrote:<br>
    </div>
    <blockquote cite="mid:53D28DBB.8000905@tycho.nsa.gov" type="cite">
      <pre wrap="">Motivated by:
<a class="moz-txt-link-freetext" href="https://bugzilla.redhat.com/show_bug.cgi?id=1098446">https://bugzilla.redhat.com/show_bug.cgi?id=1098446</a>

I believe this is always safe for booleans because we only set their
value; we are never adding new ones via semanage, unlike for example
users, ports, nodes, and interfaces.  For the rest, I was wondering why
we don't save the linked file and just reuse it on those changes rather
than re-linking each time - that seems like it would be straightforward
to do in libsemanage and make those operations significantly faster and
less memory intensive.
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

--------------030002070405000009010308--
