Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7L3oF3m008305
 for <selinux@tycho.nsa.gov>; Sat, 20 Aug 2016 23:50:15 -0400
Received: by mail-pa0-f48.google.com with SMTP id fi15so27320592pac.1
 for <selinux@tycho.nsa.gov>; Sat, 20 Aug 2016 20:49:58 -0700 (PDT)
Date: Sun, 21 Aug 2016 11:49:54 +0800
From: Jason Zaman <jason@perfinion.com>
To: Kashif ali <kashif.ali.9498@gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Subject: Re: docker daemon type label issue
Message-ID: <20160821034954.GA19749@meriadoc.perfinion.com>
References: <CAFC8oac4Ut1Qm9R_KY2-XHatmeq-m+VoraEbwGYbGdCTi+xYcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAFC8oac4Ut1Qm9R_KY2-XHatmeq-m+VoraEbwGYbGdCTi+xYcA@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sun, Aug 21, 2016 at 07:20:57AM +0500, Kashif ali wrote:
> Hi
> * When i run my docker daemon with on port for communication with client
> with the help of this command
> => "docker daemon -H localhost:2376 --selinux-enabled &"
>    then the docker daemon have following label
>    "root:unconfined_r:unconfined_t:s0-s0:c0.c1023 2535 pts/0 00:00:00
> dockerd"
> 
> *  Root user is running in the following context
> "root:unconfined_r:unconfined_t:"
> 
> * is there anything i am missing why docker daemon don't have docker_t
> label on it,
>   i know as docker daemon is started by unconfined_t domain and
> unconfined_t domain   have no domain transition then in which context the
> docker daemon should start and     as i read if init_t start the process
> then docker daemon will have docker_t label on it so   how can i run docker
> daemon with init_t context

You want to run docker in the docker_t domain? then just set a domtrans
so it will transition to docker. you do not have to go via system_u or
init_t for that. you can also use "runcon -t docker_t docker daemon..."
if there is no transition.
Are you on redhat? you might want to ask on their mailing list, they'd
be a better help probably.

-- Jason
