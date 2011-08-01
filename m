Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p71KUDlw003851
	for <selinux@tycho.nsa.gov>; Mon, 1 Aug 2011 16:30:13 -0400
Received: from mail-fx0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p71KUCOa005855
	for <selinux@tycho.nsa.gov>; Mon, 1 Aug 2011 20:30:12 GMT
Received: by fxd23 with SMTP id 23so5889122fxd.12
        for <selinux@tycho.nsa.gov>; Mon, 01 Aug 2011 13:30:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1312230225.28822.5.camel@localhost.localdomain>
References: <CAFPpqQEYmrYQWDS8t0Y2DcF3jXoyO=2f929jNuvFKyXjNG=OhQ@mail.gmail.com>
	<1312230225.28822.5.camel@localhost.localdomain>
Date: Mon, 1 Aug 2011 15:30:11 -0500
Message-ID: <CAFPpqQGgaAsLvbw_kt6YKiMEE1=GuQTGiWSVmmAP5y2VZqASyQ@mail.gmail.com>
Subject: Re: chown affecting type_transition?
From: Ted Toth <txtoth@gmail.com>
To: Dominick Grift <domg472@gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>, Joe Nall <joe@nall.com>
Content-Type: multipart/alternative; boundary=bcaec52c64df77d1c104a9777f1f
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--bcaec52c64df77d1c104a9777f1f
Content-Type: text/plain; charset=ISO-8859-1

Sorry red herring. There was a su buried in 'b' which was only used if the
chown occurred in 'a' (I didn't write these scripts). Changed su to runuser
and am moving forward again.

Ted

On Mon, Aug 1, 2011 at 3:23 PM, Dominick Grift <domg472@gmail.com> wrote:

>
>
> On Mon, 2011-08-01 at 10:32 -0500, Ted Toth wrote:
> > I'm writing policy for some scripts. Script 'a' runs script 'b' and they
> > each have their own entry file and domain type. There is a type
> transition
> > for a_t through b_exec_t to b_t in the policy. However the transition
> > doesn't happen. Script 'a' does a chown on script 'b' prior to running
> it.
> > If I remove the chown the transition does happen as expected. Can chown
> > somehow affect the file label? 'ls -Z' doesn't show any change.
>
> only thing i can think of is that the execute bit is not set for the
> owner or group you chowned the file to.
>
> In that case a dac issue.
> >
> > Ted
>

--bcaec52c64df77d1c104a9777f1f
Content-Type: text/html; charset=ISO-8859-1

Sorry red herring. There was a su buried in &#39;b&#39; which was only used if the chown occurred in &#39;a&#39; (I didn&#39;t write these scripts). Changed su to runuser and am moving forward again.<br><br>Ted <br><br><div class="gmail_quote">
On Mon, Aug 1, 2011 at 3:23 PM, Dominick Grift <span dir="ltr">&lt;<a href="mailto:domg472@gmail.com">domg472@gmail.com</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
<div><div></div><div class="h5"><br>
<br>
On Mon, 2011-08-01 at 10:32 -0500, Ted Toth wrote:<br>
&gt; I&#39;m writing policy for some scripts. Script &#39;a&#39; runs script &#39;b&#39; and they<br>
&gt; each have their own entry file and domain type. There is a type transition<br>
&gt; for a_t through b_exec_t to b_t in the policy. However the transition<br>
&gt; doesn&#39;t happen. Script &#39;a&#39; does a chown on script &#39;b&#39; prior to running it.<br>
&gt; If I remove the chown the transition does happen as expected. Can chown<br>
&gt; somehow affect the file label? &#39;ls -Z&#39; doesn&#39;t show any change.<br>
<br>
</div></div>only thing i can think of is that the execute bit is not set for the<br>
owner or group you chowned the file to.<br>
<br>
In that case a dac issue.<br>
&gt;<br>
&gt; Ted<br>
</blockquote></div><br>

--bcaec52c64df77d1c104a9777f1f--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
