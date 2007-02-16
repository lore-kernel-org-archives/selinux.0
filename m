Message-ID: <f888952b0702161308y4a373559n581ea8a61de355ee@mail.gmail.com>
Date: Fri, 16 Feb 2007 16:08:49 -0500
From: "Dave Quigley" <dquigley@gmail.com>
To: SELinux@tycho.nsa.gov
Subject: Lets try this again: Advantages and Disadvantages of Overtyping a policy
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,
    First I would like to apologize for the empty mail before but
gmail has a silly feature of sending a mail if you hit control +
enter. While it might be useful it has quite a few downfalls.

OK onto my actual question. I was wondering what advantages and
disadvantages there are to having too many types in a policy. I can
see if you have too many the allow rules to allow interaction within
the application itself can be excessive. However it also seems to me
that by having more types for the application you can have more
control over restriction the application. You see this in come
policies where they have separate types for their files in /var /etc
and /log however you don't see it for that many applications. I would
just like to hear people's thoughts on this.

Dave Quigley

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
