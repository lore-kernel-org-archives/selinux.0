Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l03Gs2Cb001846
	for <selinux@tycho.nsa.gov>; Wed, 3 Jan 2007 11:54:02 -0500
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l03GslG7021559
	for <selinux@tycho.nsa.gov>; Wed, 3 Jan 2007 16:54:47 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8) with ESMTP id l03GolSc003318
	for <selinux@tycho.nsa.gov>; Wed, 3 Jan 2007 11:50:47 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8/Submit) id l03GolN5003317
	for selinux@tycho.nsa.gov; Wed, 3 Jan 2007 11:50:47 -0500
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBP1a9Pb018041
	for <selinux@tycho.nsa.gov>; Sun, 24 Dec 2006 20:36:09 -0500
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBP1amnR022558
	for <selinux@tycho.nsa.gov>; Mon, 25 Dec 2006 01:36:48 GMT
Received: by py-out-1112.google.com with SMTP id a78so2126441pyh
        for <selinux@tycho.nsa.gov>; Sun, 24 Dec 2006 17:36:48 -0800 (PST)
Message-ID: <458F2AC7.6020007@gmail.com>
Date: Mon, 25 Dec 2006 09:35:03 +0800
From: "Nerazzurri.YANG" <spng.yang@gmail.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: please guide me a way to study selinux in Kernel
References: <4589F6A0.4010108@gmail.com>	 <1166702840.30579.164.camel@moss-spartans.epoch.ncsc.mil>	 <458B3E1B.20107@gmail.com> <1166792252.13969.7.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1166792252.13969.7.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2006-12-22 at 10:08 +0800, Nerazzurri.YANG wrote:
>> i have not received any mails i have sent to the list from i subscribe to
>> the list :-))
> 
> Strange.  But are you seeing other people's emails posted to the list
> (not just ones sent directly to you, like the replies to your message,
> but other messages posted to the list by other people, like the recent
> ones from Karl MacMillan)?


i think i have received the mail, do you mean this mail:

[PATCH] correct return value handling in libsemanage

The function semanage_direct_commit in libsemanage:direct_api.c does not 
correctly propagate error codes. This patch fixes that.

Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>


diff -r 1ecfd5befe3f src/direct_api.c
--- a/src/direct_api.c    Thu Dec 21 17:09:45 2006 -0500
+++ b/src/direct_api.c    Thu Dec 21 17:47:06 2006 -0500
@@ -603,7 +603,8 @@ static int semanage_direct_commit(semana

.............



from Karl MacMillan.

can you reply this message direct to the list, not to me.

if i can receive the reply, that may mean the mailing list
work well.


futhermore, i will reply your mail to the list (in CC), if
you will have received two same mails, it seems that my
mail client has something wrong.


> 
>> i have checked, there are not any mail in junk and spam.
>>
>> is it possbile that my setting in thunderbird is wrong?
>>
>> everything is right, when i subscribe to other mailing list
>> such as rpm, anaconda.....
> 
> I don't see anything on our end that would explain it (no bounces to
> owner-selinux for your address, and your address is listed in the list
> members).  And if you can receive mail directly from me like this, then
> there shouldn't be any real difference - they are both going through the
> same mail servers.
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
