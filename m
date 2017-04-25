Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3PD1QHp004279
 for <selinux@tycho.nsa.gov>; Tue, 25 Apr 2017 09:01:26 -0400
Reply-To: dwalsh@redhat.com
Subject: Re: Docker daemon in enforcing state
To: Umair Sarfraz <aquadestructor@gmail.com>, selinux@tycho.nsa.gov
References: <CAGJp4bCsPw_yVs=krjDO3nq0YQNuBbkVhL-TANMdWu3_DihK1w@mail.gmail.com>
From: Daniel Walsh <dwalsh@redhat.com>
Message-ID: <5f7a0612-27c7-193e-e96f-991f7af68461@redhat.com>
Date: Tue, 25 Apr 2017 09:01:01 -0400
MIME-Version: 1.0
In-Reply-To: <CAGJp4bCsPw_yVs=krjDO3nq0YQNuBbkVhL-TANMdWu3_DihK1w@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------64210E25A1EB4BCD109BE2C5"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------64210E25A1EB4BCD109BE2C5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/24/2017 05:30 PM, Umair Sarfraz wrote:
> Hi,
>
> So, I have been trying to play around with MLS (which I have 
> successfully configured) on CentOS 7. I'm aiming to apply some 
> security policies (categorization of docker containers) via MLS, but I 
> can't seem to access and get correct labels of docker daemon if I am 
> in `enforcing` mode. However, changing it to permissive mode allow me 
> to access the service and have correct label. In enforcing mode, I get 
> unlablled_t on the docker dirs.
>
>
> I am fairly new to SELinux so please excuse me if this is a silly 
> question but I am pretty sure I am missing something here. Any sort of 
> help would be appreciated. Thanks.
>
> -- 
>
> Umair Sarfraz
>
>
Do you have container-selinux installed?


--------------64210E25A1EB4BCD109BE2C5
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">On 04/24/2017 05:30 PM, Umair Sarfraz
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAGJp4bCsPw_yVs=krjDO3nq0YQNuBbkVhL-TANMdWu3_DihK1w@mail.gmail.com">
      <div dir="ltr">Hi, 
        <div><br>
        </div>
        <div>So, I have been trying to play around with MLS (which I
          have successfully configured) on CentOS 7. I'm aiming to apply
          some security policies (categorization of docker containers)
          via MLS, but I can't seem to access and get correct labels of
          docker daemon if I am in `enforcing` mode. However, changing
          it to permissive mode allow me to access the service and have
          correct label. In enforcing mode, I get unlablled_t on the
          docker dirs. </div>
        <div><br>
        </div>
        <div><br>
        </div>
        <div>I am fairly new to SELinux so please excuse me if this is a
          silly question but I am pretty sure I am missing something
          here. Any sort of help would be appreciated. Thanks.<br
            clear="all">
          <div><br>
          </div>
          -- <br>
          <div class="gmail_signature" data-smartmail="gmail_signature">
            <div dir="ltr">
              <div>
                <div dir="ltr">
                  <div><br>
                  </div>
                  <div><span style="font-size:12.8px">Umair Sarfraz</span><br>
                  </div>
                </div>
                <div dir="ltr"><br>
                  <div><br>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <p>Do you have container-selinux installed?<br>
    </p>
  </body>
</html>

--------------64210E25A1EB4BCD109BE2C5--
