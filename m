Subject: Re: Selinux Docker issues
To: Naina Emmanuel <nemmanuel1992@gmail.com>, Vit Mojzis <vmojzis@redhat.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, jwcart2@tycho.nsa.gov,
 david.d.merritt@gmail.com, selinux@tycho.nsa.gov
References: <CAN=9EoTdFQFWLNakFYFKEW5co8HV3ewbK9KGtB_Zk21AZYTgMA@mail.gmail.com>
From: Daniel J Walsh <dwalsh@redhat.com>
Message-ID: <cf113295-362c-39b1-9e1f-0cc07bd7db38@redhat.com>
Date: Thu, 5 May 2016 09:03:36 -0400
MIME-Version: 1.0
In-Reply-To: <CAN=9EoTdFQFWLNakFYFKEW5co8HV3ewbK9KGtB_Zk21AZYTgMA@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------9C3287F6291AC3ED61A752F6"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------9C3287F6291AC3ED61A752F6
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit



On 05/05/2016 02:32 AM, Naina Emmanuel wrote:
> Good Morning,
> I am working on docker and its securituy through SElinux, I am facing 
> some problems and have some Questions to ask...
>
> Q1: If for the containers, we have MLS policy to be configured 
> SelinuxType=mls in /etc/selinux/config,  then on the host for other 
> modules we have targeted policy, how can take these two different 
> types simultaneously ?
>
The HOSTS SELinux policy affects the container.  Inside of the 
containers, the system thinks that SELinux is disabled.  We don't allow 
you to run two different SELinux policies with the same kernel. You 
would need kvm/virtualization for this and to have a separate VM from 
the host.
> Q2: Docker is running on my Centos7, still it is giving unconfined_t 
> label on docker process, (policy is configured as selinuxtype=mls and 
> selinux=permissive)
>
If you are running  unconfined_t then you are running on a targeted 
host,  What the configuration of content inside of the container does 
not matter.  See above.

Docker should be running as docker_t, if you have docker-selinux package 
installed and everything labeled properly.
> Q3: In targeted rpm package i have found namespace.te and cgroup.te, 
> if docker works on mls, then why these policy modules are given in 
> targeted rpm?
I have never heard of these, The docker-selinux policy ships with the 
docker.te, it also uses types defined in the virt.te files.
>
> Q4: Where is mls policy is located? As we have .te policy for targeted
>
MLS Policy and targeted are shared.  MLS Should be able to work with 
docker-selinux, with a few tweaks to make sure that
docker_t runs ranged.  May need some mls overrides.   You might also 
need to add virt.pp if that is not in the default mls package.

I would suggest that you setup the host to run in MLS mode and then 
modify docker-selinux package to run in an MLS environment.
docker will pick out random MCS Labels for running containers, so you 
would need to override this behaviour if you want a container
to run at a particular level.

Something like

docker run -ti --security-opt label=level:s15:c1,c2 rhel7 /bin/sh


>
> please guide me in these regard
>
> Thanks in advance
>
> *
> *
> *
> *
> *
> *
> *
> *
> /Engr. Naina Emmanuel/
> *Linux Essential Certified (LEPDC)**
> *
> *Cisco Certified Network Associate (CCNA)*
> *Computer Engineering Department, UET Taxila
> *
> *Information Security, CS Department, CIIT Islamabad
> *
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.


--------------9C3287F6291AC3ED61A752F6
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=windows-1252"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 05/05/2016 02:32 AM, Naina Emmanuel
      wrote:<br>
    </div>
    <blockquote
cite="mid:CAN=9EoTdFQFWLNakFYFKEW5co8HV3ewbK9KGtB_Zk21AZYTgMA@mail.gmail.com"
      type="cite">
      <div dir="ltr">
        <div>
          <div class="gmail_signature">
            <div dir="ltr">
              <div dir="ltr">
                <div dir="ltr">
                  <div dir="ltr">
                    <div dir="ltr">
                      <div dir="ltr">
                        <div dir="ltr">
                          <div dir="ltr">
                            <div>Good Morning,</div>
                            <div>I am working on docker and its
                              securituy through SElinux, I am facing
                              some problems and have some Questions to
                              ask...</div>
                            <div><br>
                            </div>
                            <div>Q1: If for the containers, we have MLS
                              policy to be configured SelinuxType=mls in
                              /etc/selinux/config,  then on the host for
                              other modules we have targeted policy, how
                              can take these two different types
                              simultaneously ? </div>
                            <div><br>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    The HOSTS SELinux policy affects the container.  Inside of the
    containers, the system thinks that SELinux is disabled.  We don't
    allow you to run two different SELinux policies with the same
    kernel. You would need kvm/virtualization for this and to have a
    separate VM from the host.<br>
    <blockquote
cite="mid:CAN=9EoTdFQFWLNakFYFKEW5co8HV3ewbK9KGtB_Zk21AZYTgMA@mail.gmail.com"
      type="cite">
      <div dir="ltr">
        <div>
          <div class="gmail_signature">
            <div dir="ltr">
              <div dir="ltr">
                <div dir="ltr">
                  <div dir="ltr">
                    <div dir="ltr">
                      <div dir="ltr">
                        <div dir="ltr">
                          <div dir="ltr">
                            <div>Q2: Docker is running on my Centos7,
                              still it is giving unconfined_t label on
                              docker process, (policy is configured as
                              selinuxtype=mls and selinux=permissive)</div>
                            <div><br>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    If you are running  unconfined_t then you are running on a targeted
    host,  What the configuration of content inside of the container
    does not matter.  See above.<br>
    <br>
    Docker should be running as docker_t, if you have docker-selinux
    package installed and everything labeled properly.<br>
    <blockquote
cite="mid:CAN=9EoTdFQFWLNakFYFKEW5co8HV3ewbK9KGtB_Zk21AZYTgMA@mail.gmail.com"
      type="cite">
      <div dir="ltr">
        <div>
          <div class="gmail_signature">
            <div dir="ltr">
              <div dir="ltr">
                <div dir="ltr">
                  <div dir="ltr">
                    <div dir="ltr">
                      <div dir="ltr">
                        <div dir="ltr">
                          <div dir="ltr">
                            <div>Q3: In targeted rpm package i have
                              found namespace.te and cgroup.te, if
                              docker works on mls, then why these policy
                              modules are given in targeted rpm?</div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    I have never heard of these, The docker-selinux policy ships with
    the docker.te, it also uses types defined in the virt.te files.<br>
    <blockquote
cite="mid:CAN=9EoTdFQFWLNakFYFKEW5co8HV3ewbK9KGtB_Zk21AZYTgMA@mail.gmail.com"
      type="cite">
      <div dir="ltr">
        <div>
          <div class="gmail_signature">
            <div dir="ltr">
              <div dir="ltr">
                <div dir="ltr">
                  <div dir="ltr">
                    <div dir="ltr">
                      <div dir="ltr">
                        <div dir="ltr">
                          <div dir="ltr">
                            <div><br>
                            </div>
                            <div>Q4: Where is mls policy is located? As
                              we have .te policy for targeted </div>
                            <div><br>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    MLS Policy and targeted are shared.  MLS Should be able to work with
    docker-selinux, with a few tweaks to make sure that<br>
    docker_t runs ranged.  May need some mls overrides.   You might also
    need to add virt.pp if that is not in the default mls package.<br>
    <br>
    I would suggest that you setup the host to run in MLS mode and then
    modify docker-selinux package to run in an MLS environment.  <br>
    docker will pick out random MCS Labels for running containers, so
    you would need to override this behaviour if you want a container<br>
    to run at a particular level.<br>
    <br>
    Something like<br>
    <br>
    docker run -ti --security-opt label=level:s15:c1,c2 rhel7 /bin/sh<br>
    <br>
    <br>
    <blockquote
cite="mid:CAN=9EoTdFQFWLNakFYFKEW5co8HV3ewbK9KGtB_Zk21AZYTgMA@mail.gmail.com"
      type="cite">
      <div dir="ltr">
        <div>
          <div class="gmail_signature">
            <div dir="ltr">
              <div dir="ltr">
                <div dir="ltr">
                  <div dir="ltr">
                    <div dir="ltr">
                      <div dir="ltr">
                        <div dir="ltr">
                          <div dir="ltr">
                            <div><br>
                            </div>
                            <div>please guide me in these regard</div>
                            <div><br>
                            </div>
                            <div>Thanks in advance</div>
                            <font size="4">
                              <div><br>
                              </div>
                              <div style="font-weight:bold"><font
                                  size="4"><b><br>
                                  </b></font></div>
                              <div style="font-weight:bold"><font
                                  size="4"><b><br>
                                  </b></font></div>
                              <div style="font-weight:bold"><font
                                  size="4"><b><br>
                                  </b></font></div>
                              <div style="font-weight:bold"><font
                                  size="4"><b><br>
                                  </b></font></div>
                              <font style="font-weight:bold"
                                color="#666666"><i>Engr. Naina Emmanuel</i></font></font>
                            <div><b
                                style="color:rgb(102,102,102);font-size:small">Linux
                                Essential Certified (LEPDC)</b><font
                                size="2" color="#666666"><b><br>
                                </b></font></div>
                            <div><font size="2" color="#666666"><b>Cisco
                                  Certified Network Associate (CCNA)</b></font></div>
                            <div><b
                                style="color:rgb(102,102,102);font-size:small">Computer
                                Engineering Department, UET Taxila<br>
                              </b></div>
                            <div><b
                                style="color:rgb(102,102,102);font-size:small">Information
                                Security, CS Department, CIIT Islamabad<br>
                              </b></div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
Selinux mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a>
To unsubscribe, send email to <a class="moz-txt-link-abbreviated" href="mailto:Selinux-leave@tycho.nsa.gov">Selinux-leave@tycho.nsa.gov</a>.
To get help, send an email containing "help" to <a class="moz-txt-link-abbreviated" href="mailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------9C3287F6291AC3ED61A752F6--
