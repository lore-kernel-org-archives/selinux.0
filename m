Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA18292
	for <selinux@tycho.nsa.gov>; Thu, 20 Dec 2001 10:30:20 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA24028
	for <selinux@tycho.nsa.gov>; Thu, 20 Dec 2001 15:30:04 GMT
Received: from sparcy.internal.lan (dsl092-233-010.phl1.dsl.speakeasy.net [66.92.233.10])
	by jazzswing.ncsc.mil  with ESMTP id PAA24024
	for <selinux@tycho.nsa.gov>; Thu, 20 Dec 2001 15:30:04 GMT
Date: Thu, 20 Dec 2001 10:28:25 -0500 (EST)
From: Noah silva <nsilva@atari-source.com>
To: =?ISO-2022-JP?B?GyRCQX1FRBsoQiAbJEJFLzwhGyhC?= <tmasuda@chi.it.teu.ac.jp>
cc: selinux@tycho.nsa.gov
Subject: Re: Japanese Document
In-Reply-To: <20011220024019.831CE122F@xenon.chi.it.teu.ac.jp>
Message-ID: <Pine.LNX.4.21.0112200959120.27491-100000@sparcy.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I sometimes use Kon.  My guess is that perhaps the policy in effect
prevents something Kon tries to do.  I havn't examined the policies well
enough to know exactly what.  I can tell you Kon is a bit touchy anyhow
(f.e. it won't work as a login shell).

(for those who don't know, Kon is a program that allows japanese text on
the console.  It will switch the console to graphics mode, and load
japanese fonts.  The console then works [mostly] normally, except that
japanese charicter (kana, kanji) escape sequences are interpreted and the
relevent charicters are displayed.  English text displays as normal.)

I would guess it probably has something to do with how it uses the screen.

  -- noah silva 



On Thu, 20 Dec 2001, [ISO-2022-JP] 増田 哲次 wrote:

> Hello!
> 
> My name is Tetsuji Masuda , I`m university student in Japan.
> 
> I installed SELinux(2.4.9) in RH7.1. However I can`t use `kon` command in console window. When I pushed returen button after I typed `kon`, the window was, somehow, freezed. What's the problem about that? 
> 
> This is log of kon in /var/log/messages.
> ==========================================================================================
> Dec 17 14:20:27 pc07 kernel: 
... 
> ==========================================================================================
> 
> I translated the policy document with Japanese as research. I'm not
>sure it was correct or not. However I want to use it for report of it. If
>you agreed of it or disagreed, please let me know. And If you have a good
>idea instend of it, it's also tell me the detale of it. 
> 
> --
> 増田 哲次 /Tetsuji Masuda
> 東京工科大学工学部情報工学科4年 /Tokyo University of Technology
> 千種研究室 /Chigusa Laboratory
> MAIL:tmasuda@chi.it.teu.ac.jp
> 
> 


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
