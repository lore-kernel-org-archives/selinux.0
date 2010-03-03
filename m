Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o23FEQcQ016399
	for <selinux@tycho.nsa.gov>; Wed, 3 Mar 2010 10:14:26 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o23FElrD009206
	for <selinux@tycho.nsa.gov>; Wed, 3 Mar 2010 15:14:47 GMT
Message-ID: <4B8E7CCC.8040407@redhat.com>
Date: Wed, 03 Mar 2010 10:14:20 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: TaurusHarry <harrytaurus2002@hotmail.com>
CC: refpolicy-mailing-list <refpolicy@oss1.tresys.com>,
        selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: Re: [refpolicy] How to implement the "if-then-else" logic in refpolicy
 interface?
References: <BAY111-W68D4C9E39582E71A1BA31AB3A0@phx.gbl>
In-Reply-To: <BAY111-W68D4C9E39582E71A1BA31AB3A0@phx.gbl>
Content-Type: multipart/alternative;
 boundary="------------040308090503030700090006"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040308090503030700090006
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 8bit

On 03/03/2010 01:37 AM, TaurusHarry wrote:
> Hi SELinux experts,
>
> Thanks a lot for taking a look at my question, how could I implement
> the bash "if-then-else" and "test" grammar in current refpolicy
> interface? For example, if I don't want the user_t to have the
> privilege to execute any kind of shell, what proper grammar should I
> use to implement something with the same logic as 'if ! test "X$1" =
> "Xuser_t"' in the corecomd_exec_shell interface:
>
> interface(`corecmd_exec_shell',`
> gen_require(`
> type bin_t, shell_exec_t;
> ')
>
> if ! test "X$1" = "Xuser_t"; then
> list_dirs_pattern($1, bin_t, bin_t)
> read_lnk_files_pattern($1, bin_t, bin_t)
> can_exec($1, shell_exec_t)
> fi
> ')
>
> Thank you very much!
>
> Best regards,
> Harry
>
> ------------------------------------------------------------------------
> 搜索本应是彩色的,快来体验新一代搜索引擎-必应,精美图片每天换哦! 立即试
> 用！ <http://cn.bing.com/?form=CRMADS%20>
>
>
> _______________________________________________
> refpolicy mailing list
> refpolicy@oss.tresys.com
> http://oss.tresys.com/mailman/listinfo/refpolicy
>   
No that would not work. You need to define a new user type that a user
can login with. user_nobin_t, or something. Then you are going to need
to define all the rules necessary for this user to login and execute the
shell_exec_t and any other programs that you want them to run.

You write this in policy not in shell scripting.

--------------040308090503030700090006
Content-Type: text/html; charset=GB2312
Content-Transfer-Encoding: 8bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=GB2312" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
On 03/03/2010 01:37 AM, TaurusHarry wrote:
<blockquote cite="mid:BAY111-W68D4C9E39582E71A1BA31AB3A0@phx.gbl"
 type="cite">
  <style><!--
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 10pt;
font-family:Verdana
}
--></style>Hi
SELinux experts,<br>
  <br>
Thanks a lot for taking a look at my question, how could I implement
the bash "if-then-else" and "test" grammar in current refpolicy
interface? For example, if I don't want the user_t to have the
privilege to execute any kind of shell, what proper grammar should I
use to implement something with the same logic as 'if ! test "X$1" =
"Xuser_t"' in the corecomd_exec_shell interface:<br>
  <br>
interface(`corecmd_exec_shell',`<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gen_require(`<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type bin_t, shell_exec_t;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ')<br>
  <br>
if ! test "X$1" = "Xuser_t"; then<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_dirs_pattern($1, bin_t, bin_t)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; read_lnk_files_pattern($1, bin_t, bin_t)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; can_exec($1, shell_exec_t)<br>
fi<br>
')<br>
  <br>
Thank you very much!<br>
  <br>
Best regards,<br>
Harry<br>
  <br>
  <hr>搜索本应是彩色的,快来体验新一代搜索引擎-必应,精美图片每天换哦! <a moz-do-not-send="true"
 href="http://cn.bing.com/?form=CRMADS%20" target="_new">立即试用！</a>
  <pre wrap="">
<fieldset class="mimeAttachmentHeader"></fieldset>
_______________________________________________
refpolicy mailing list
<a class="moz-txt-link-abbreviated" href="mailto:refpolicy@oss.tresys.com">refpolicy@oss.tresys.com</a>
<a class="moz-txt-link-freetext" href="http://oss.tresys.com/mailman/listinfo/refpolicy">http://oss.tresys.com/mailman/listinfo/refpolicy</a>
  </pre>
</blockquote>
No that would not work.&nbsp; You need to define a new user type that a user
can login with.&nbsp; user_nobin_t, or something.&nbsp; Then you are going to
need to define all the rules necessary for this user to login and
execute the shell_exec_t and any other programs that you want them to
run.<br>
<br>
You write this in policy not in shell scripting.<br>
</body>
</html>

--------------040308090503030700090006--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
