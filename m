Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qBD2gBoZ016558
	for <selinux@tycho.nsa.gov>; Wed, 12 Dec 2012 21:42:11 -0500
In-Reply-To: <21751d382c2cacb70f450cd1483cecdd@countercultured.net>
References: <21751d382c2cacb70f450cd1483cecdd@countercultured.net>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="----C8YVU2MDWTI1X5JC8MQ9ZF6MYN3JRD"
Subject: Re: semanage cleanup
From: Russell Coker <russell@coker.com.au>
Reply-to: russell@coker.com.au
Date: Thu, 13 Dec 2012 13:41:37 +1100
To: David Quigley <dpquigl@davequigley.com>, selinux@tycho.nsa.gov
Message-ID: <a3f09cd7-c023-43ff-86c0-e36ad848b57f@email.android.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------C8YVU2MDWTI1X5JC8MQ9ZF6MYN3JRD
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Better help text is always a good thing, using a standard way of processi=
ng data is also good.

Semanage-fcontext doesn't seem to give any real benefit over "semanage fc=
ontext" though.

David Quigley <dpquigl@davequigley.com> wrote:

>I've given a few talks on SELinux over the past year and I've spoken to
>
>a bunch of people on google+ about SELinux and one topic keeps coming=20
>up. Many people find semanage to be large and convoluted with the help=20
>text being way to large to sort through. The latter part of the=20
>complaint is easy to address. The code for argument parsing in semanage
>
>(last time I checked) doesn't use things like argparse. If we switched=20
>it over to argparse we could get per sub-command help messages that=20
>would be more useful to people when they messed up a sub-command. Would
>
>anyone be opposed if I spent the time to migrate semanage argument=20
>parsing and help messages over to argparse or a similar library?
>
>The second problem some people have is that semanage is a multiplexed=20
>command. I'm not sure what the right way to approach this is. If we
>look=20
>at other applications which are multiplexers we get a few examples.=20
>Busybox is the first example and covers most of the discussion. The two
>
>ways of invoking busybox is either busybox command_name arguments or=20
>command_name arguments where command_name is a symlink to the busybox=20
>binary. If we chose the latter way of handling it we would need to=20
>decide on one of two ways of naming the sub-commands. The first method=20
>would be to come up with a naming convention for the subcommands to=20
>avoid collisions like selogin for semanage login or seusers for
>semanage=20
>users etc. The second method would be to do what git use to do which is
>
>prepend the tool name onto the subcommand. For example=20
>semanage-fcontext, semanage-login, semanage-users etc... If we chose=20
>this route then we'd need to investigate what git's reason for moving=20
>away from it was and decide if it applies to our situation as well.
>
>If we convert over to argparse for argument parsing it should be=20
>trivial to do some processing on argv[0] to extract out a subcommand=20
>from a name and use the correct routines. I'm not sure that solving the
>
>second problem gets us substantial gains or if having help messages
>that=20
>are specific to each subcommand will help users more.
>
>Does anyone have any thoughts about this?
>
>--
>This message was distributed to subscribers of the selinux mailing
>list.
>If you no longer wish to subscribe, send mail to
>majordomo@tycho.nsa.gov with
>the words "unsubscribe selinux" without quotes as the message.

--=20
My blog     http://etbe.coker.com.au
Sent from an Xperia X10 Android phone with K-9 Mail.=20
------C8YVU2MDWTI1X5JC8MQ9ZF6MYN3JRD
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head/><body><html><head></head><body>Better help text is always a =
good thing, using a standard way of processing data is also good.<br>
<br>
Semanage-fcontext doesn&#39;t seem to give any real benefit over &quot;se=
manage fcontext&quot; though.<br><br><div class=3D"gmail_quote">David Qui=
gley &lt;dpquigl@davequigley.com&gt; wrote:<blockquote class=3D"gmail_quo=
te" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 2=
04, 204); padding-left: 1ex;">
<pre style=3D"white-space: pre-wrap; word-wrap:break-word; font-family: s=
ans-serif; margin-top: 0px">I've given a few talks on SELinux over the pa=
st year and I've spoken to <br />a bunch of people on google+ about SELin=
ux and one topic keeps coming <br />up. Many people find semanage to be l=
arge and convoluted with the help <br />text being way to large to sort t=
hrough. The latter part of the <br />complaint is easy to address. The co=
de for argument parsing in semanage <br />(last time I checked) doesn't u=
se things like argparse. If we switched <br />it over to argparse we coul=
d get per sub-command help messages that <br />would be more useful to pe=
ople when they messed up a sub-command. Would <br />anyone be opposed if =
I spent the time to migrate semanage argument <br />parsing and help mess=
ages over to argparse or a similar library?<br /><br />The second problem=
 some people have is that semanage is a multiplexed <br />command. I'm no=
t sure what the right way to approach this is. If
we look <br />at other applications which are multiplexers we get a few e=
xamples. <br />Busybox is the first example and covers most of the discus=
sion. The two <br />ways of invoking busybox is either busybox command_na=
me arguments or <br />command_name arguments where command_name is a syml=
ink to the busybox <br />binary. If we chose the latter way of handling i=
t we would need to <br />decide on one of two ways of naming the sub-comm=
ands. The first method <br />would be to come up with a naming convention=
 for the subcommands to <br />avoid collisions like selogin for semanage =
login or seusers for semanage <br />users etc. The second method would be=
 to do what git use to do which is <br />prepend the tool name onto the s=
ubcommand. For example <br />semanage-fcontext, semanage-login, semanage-=
users etc... If we chose <br />this route then we'd need to investigate w=
hat git's reason for moving <br />away from it was and decide if it appli=
es to our situation as well.<br /><br />If we
convert over to argparse for argument parsing it should be <br />trivial =
to do some processing on argv[0] to extract out a subcommand <br />from a=
 name and use the correct routines. I'm not sure that solving the <br />s=
econd problem gets us substantial gains or if having help messages that <=
br />are specific to each subcommand will help users more.<br /><br />Doe=
s anyone have any thoughts about this?<br /><br />--<br />This message wa=
s distributed to subscribers of the selinux mailing list.<br />If you no =
longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br />=
the words "unsubscribe selinux" without quotes as the message.<br /></pre=
></blockquote></div><br>
-- <br>
My blog     <a href=3D"http://etbe.coker.com.au">http://etbe.coker.com.au=
</a><br>
Sent from an Xperia X10 Android phone with K-9 Mail. </body></html></body=
></html>
------C8YVU2MDWTI1X5JC8MQ9ZF6MYN3JRD--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
