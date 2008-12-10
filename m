Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mBAHM5V5030295
	for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2008 12:22:05 -0500
Received: from mail-ew0-f13.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mBAHM4E1019690
	for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2008 17:22:04 GMT
Received: by ewy6 with SMTP id 6so923515ewy.18
        for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2008 09:22:03 -0800 (PST)
Message-ID: <dd18b0c30812100922n1ecd844s1fc3d8113ef91cff@mail.gmail.com>
Date: Wed, 10 Dec 2008 09:22:03 -0800
From: "Justin Mattock" <justinmattock@gmail.com>
To: erahul29@yahoo.com
Subject: Re: Non root user cannot execute semanage, semodule
Cc: sds@tycho.nsa.gov, dwalsh@redhat.com, casey@schaufler-ca.com,
        selinux@tycho.nsa.gov
In-Reply-To: <652528.7919.qm@web50204.mail.re2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <652528.7919.qm@web50204.mail.re2.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Dec 10, 2008 at 8:34 AM, Rahul Jain <erahul29@yahoo.com> wrote:
> Thankyou All,
>
> This community is really awesome.
>
> As suggested by Stephen I used sudo in order to allow a non root user
> execute the priviledged commands like semodule and semanage and protected
> the configuration file using SELinux. Though I tried to tweak the
> policycoreutils also to get the things done but it did not work. The
> reason being, the some intermediate directories that are created when these
> commands are executed. The owner of these directories is root and a non root
> user is not able to access these directories.
>
> For me it was important to allow security officer execute these commands
> because his role entitles him to perform all security policy related tasks.
> Semodule was needed to load the policy modules while semanage was required
> to map the Linux users with the selinux users.
>
> Thanks and Regards
> Rahul Jain
>
>
>

Yeah that makes sense.
glad you up and running.

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
