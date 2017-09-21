Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v8LFCGNv016260
 for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2017 11:12:17 -0400
Received: by mail-wr0-f170.google.com with SMTP id l39so4745358wrl.12
 for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2017 07:39:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPihp9nPSh1mnnAsZ3aHL3KqBq80RQKLjq8N_AF29iNn3UKj+A@mail.gmail.com>
References: <CAPihp9nPSh1mnnAsZ3aHL3KqBq80RQKLjq8N_AF29iNn3UKj+A@mail.gmail.com>
From: Nick Kralevich <nnk@google.com>
Date: Thu, 21 Sep 2017 07:38:05 -0700
Message-ID: <CAFJ0LnG7MR=ahh-tmdA=g0DonuUSkB9V7bHnqXbXeJs++-MMPQ@mail.gmail.com>
To: masoom alam <masoom.alam@gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: A casestudy where selinux has stopped malware attacks
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Android has tried to document pretty extensively how the reduction of
attack surface provided by SELinux has resulted in a significant
percentage of bugs being unreachable.

See, for example
https://www.blackhat.com/docs/us-17/thursday/us-17-Kralevich-Honey-I-Shrunk-The-Attack-Surface-Adventures-In-Android-Security-Hardening.pdf
slide 52, where 44% of our security bulletin class bugs are reduced in
severity because of SELinux attack surface management.

However, SELinux's primary goal isn't attack surface management
(although it's very good at it). It's primary purpose is containment
and being able to reason about the state of the system assuming a
compromise of any component. If SELinux stops a malware author, that
malware author will simply choose to not publish their non-working
code. Most people, including malware authors, will only celebrate
their successes, but won't publicize their failures. Measurements in
this area are hard.

-- Nick


On Wed, Sep 20, 2017 at 9:13 PM, masoom alam <masoom.alam@gmail.com> wrote:
> Hi every one,
>
> Do we have some thing like the mentioned subject documented?
>
> Thank you.
>
>
> ----
> Dr. Masoom Alam,
> Associate Professor,
> Department of Computer Science,
> COMSATS Institute of Information Technology,
> Park Road, Islamabad
> Off +92-51-9049-5391
> Cell +92-332-9298-404



-- 
Nick Kralevich | Android Security | nnk@google.com | 650.214.4037
