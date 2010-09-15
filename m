Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o8F9NPLX001655
	for <selinux@tycho.nsa.gov>; Wed, 15 Sep 2010 05:23:25 -0400
Received: from new1.smtp.messagingengine.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o8F9NO25019863
	for <selinux@tycho.nsa.gov>; Wed, 15 Sep 2010 09:23:24 GMT
From: Roberto Sassu <roberto.sassu@polito.it>
To: selinux@lists.fedoraproject.org
Subject: Re: Fedora UBAC feature
Date: Wed, 15 Sep 2010 11:23:21 +0200
Cc: selinux@tycho.nsa.gov
References: <201009151050.45071.roberto.sassu@polito.it>
In-Reply-To: <201009151050.45071.roberto.sassu@polito.it>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201009151123.22302.roberto.sassu@polito.it>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 15 September 2010 10:50:44 Roberto Sassu wrote:
> Hi all
> 
> i want to use UBAC feature in order to isolate an user from each other. 
> I created two users user1_u and user2_u mapped respectively to user1 and user2, and 
> i assigned them the role user_r.
> Then i created two directories 'a' and 'b' labeled respectively user1_u:object_r:user_home_t:s0 
> and user2_u:object_r:user_home_t:s0. What i'm expecting is that user1 can access 'a' and not 'b', 
> viceversa for user2, but user1 is allowed to access both directories.
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 

Oh, sorry. I have not seen the UBAC variable is overwritten in the Fedora rpm spec file.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
