MIME-Version: 1.0
In-Reply-To: <53FB4192.8090203@gmail.com>
References: <53FB19C7.1040500@gmail.com> <53FB35D2.3030307@tycho.nsa.gov>
 <53FB4192.8090203@gmail.com>
Date: Mon, 25 Aug 2014 10:30:05 -0400
Message-ID: <CAHC9VhSwgERb2NoY8vK3nT=wxBh7fyaD7ECGoxcRij5P6u1XKQ@mail.gmail.com>
Subject: Re: semanage interface has no effect
From: Paul Moore <paul@paul-moore.com>
To: "Stepan G. Fedorov" <stfedorov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: Selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Aug 25, 2014 at 10:00 AM, Stepan G. Fedorov <stfedorov@gmail.com> wrote:
> 25.08.2014 17:10, Stephen Smalley пишет:
>
>> Legacy network checks are gone; use peer labeling or secmark instead,
>> http://paulmoore.livejournal.com/tag/documentation
>
>
> Thank you for quick reply!
>
> In case of "just installed" system, where no iptables SECMARK rules present,
> and no labeled packets arrive on network interface - what will be selinux
> contexts of all incoming packets?

In this case the incoming packets would be labeled "unlabeled_t", just
like any other unlabeled data on the system.

-- 
paul moore
www.paul-moore.com
